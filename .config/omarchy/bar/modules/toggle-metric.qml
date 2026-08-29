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

  implicitWidth: button.implicitWidth
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

  function toggleMonitoring() {
    monitoring = !monitoring
    if (monitoring) {
      refreshTimer.start()
      refresh()
    } else {
      refreshTimer.stop()
      if (metricProcess.running) metricProcess.running = false
      displayText = label + " --"
    }
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
    id: metricProcess
    command: ["bash", "-lc", root.commandLine]
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
