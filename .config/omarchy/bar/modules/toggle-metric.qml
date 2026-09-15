import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root

  property bool monitoring: false
  property string displayText: String(settings && settings.label ? settings.label : "Metric") + " --"
  readonly property string label: String(settings && settings.label ? settings.label : "Metric")
  readonly property string commandLine: String(settings && settings.exec ? settings.exec : "")
  readonly property string metricId: label === "CPU" ? "cpu-usage"
    : label === "RAM" ? "ram-usage"
    : label === "GPU" ? "gpu-usage"
    : label === "NET" ? "network-speed"
    : ""
  readonly property string stateCommand: Quickshell.env("HOME") + "/.config/omarchy/bar/scripts/metric-monitor-state"
  readonly property string sampleCommand: Quickshell.env("HOME") + "/.config/omarchy/bar/scripts/shared-metric-sample"
  readonly property string statePath: Quickshell.env("HOME") + "/.local/state/omarchy/bar-metrics.json"

  // 网络速率文本变化较大，固定宽度避免 Bar 每秒左右跳动。
  implicitWidth: metricId === "network-speed" ? 190 : 88
  implicitHeight: button.implicitHeight

  function refresh() {
    if (monitoring && commandLine !== "" && !metricProcess.running) metricProcess.running = true
  }

  function updateOutput(raw) {
    try {
      var result = JSON.parse(raw)
      displayText = String(result.text || (label + " --"))
    } catch (error) {
      displayText = label + " --"
    }
  }

  function applyMonitoring(enabled) {
    monitoring = enabled
    if (monitoring) {
      refreshTimer.start()
      refresh()
    } else {
      refreshTimer.stop()
      if (metricProcess.running) metricProcess.running = false
      displayText = label + " --"
    }
  }

  function applyState(raw) {
    try {
      var state = JSON.parse(raw || "{}")
      applyMonitoring(state[metricId] === true)
    } catch (error) {
      applyMonitoring(false)
    }
  }

  function toggleMonitoring() {
    if (metricId === "" || stateProcess.running) return
    stateProcess.command = [stateCommand, "toggle", metricId]
    stateProcess.running = true
  }

  // The bar's outer click dispatcher invokes this on custom QML modules.
  function triggerPress(button) {
    if (button === Qt.LeftButton) toggleMonitoring()
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.displayText
    active: root.monitoring
    tooltipText: root.monitoring
      ? root.label + " 检测中 · 点击停止"
      : root.label + " 检测已关闭 · 点击启动"
    onPressed: root.toggleMonitoring()
  }

  Process {
    id: stateProcess
  }

  FileView {
    id: stateFile
    path: root.statePath
    watchChanges: true
    printErrors: false
    onLoaded: root.applyState(text())
    onFileChanged: reload()
  }

  Process {
    id: metricProcess
    command: [root.sampleCommand, root.metricId, root.commandLine]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.updateOutput(text)
    }
  }

  Timer {
    id: refreshTimer
    interval: 1000
    repeat: true
    running: false
    onTriggered: root.refresh()
  }
}
