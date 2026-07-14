import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#100F0F"   // Flexoki black

    // ---- palette ----
    readonly property color txBright: "#E6E4D9"  // base-100
    readonly property color tx:       "#CECDC3"  // base-200
    readonly property color muted:    "#878580"  // base-500
    readonly property color faint:    "#6F6E69"  // base-600
    readonly property color ui:       "#282726"  // base-900
    readonly property color border:   "#343331"  // base-850
    readonly property color red:      "#D14D41"

    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            errorText.opacity = 1
            password.text = ""
            password.focus = true
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 28
        width: 320

        // Clock
        Text {
            id: clock
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.tx
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 88
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), "HH:mm")
            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: clock.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }

        // Date
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.muted
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 16
            text: Qt.formatDate(new Date(), "dddd, dd MMMM")
        }

        Item { width: 1; height: 12 }  // spacer

        // Password field
        Rectangle {
            width: parent.width
            height: 48
            radius: 8
            color: root.ui
            border.color: root.border
            border.width: 1

            TextField {
                id: password
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14
                echoMode: TextInput.Password
                passwordCharacter: "•"
                color: root.tx
                font.family: "CommitMono Nerd Font"
                font.pixelSize: 16
                verticalAlignment: TextInput.AlignVCenter
                focus: true
                background: Item {}
                placeholderText: "enter password"
                placeholderTextColor: root.faint
                onAccepted: sddm.login(userCombo.currentText, password.text, sessionCombo.currentIndex)
                Keys.onPressed: function(e) { errorText.opacity = 0 }
            }
        }

        // Error / caps
        Text {
            id: errorText
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.red
            opacity: 0
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 13
            text: "authentication failed"
            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        // User selector
        ComboBox {
            id: userCombo
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            model: userModel
            textRole: "name"
            currentIndex: userModel.lastIndex
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 14
            flat: true
        }
    }

    // Session selector (bottom-left, subtle)
    Row {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 24
        spacing: 8
        Text {
            color: root.faint
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 13
            text: "session"
            anchors.verticalCenter: parent.verticalCenter
        }
        ComboBox {
            id: sessionCombo
            model: sessionModel
            currentIndex: sessionModel.lastIndex
            textRole: "name"
            font.family: "CommitMono Nerd Font"
            font.pixelSize: 13
            width: 220
            flat: true
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}
