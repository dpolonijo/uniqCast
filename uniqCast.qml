import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    title: qsTr("UniqCast")
    width: 640
    height: 1136
    color: "#252525"

    function authorization(username, password) {
        var xmlhttp = new XMLHttpRequest();
        var url = "http://176.31.182.158:3001/auth/local";

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var component = Qt.createComponent("new_window.qml")
                var window = component.createObject()
                window.show();
                error_msg.text = ""
            }
            else {
                var response = JSON.parse(xmlhttp.responseText);
                var jwt = response['jwt'];
                if(jwt !== "")
                    error_msg.text = "Wrong login data. Please try again!"
            }
        }

        xmlhttp.open("POST", url, true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send("identifier=" + username + "&password=" + password);
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: title
            Layout.topMargin: 140
            text: '<font color="#fff"><b>uniq</b>Cast</font>'
            font { family: 'Verdana'; pixelSize: 42 }
            color: "#fff"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            source: "img/user.png"
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 120
        }

        TextField {
            id: username
            Layout.topMargin: 40
            placeholderText: "User Name"
            font.pixelSize: 24
            style: TextFieldStyle {
                textColor: "#fff"
                placeholderTextColor: "#999"
                background: Rectangle {
                    implicitWidth: 490
                    implicitHeight: 110
                    color: "transparent"
                }
            }
            Rectangle {
                width: 490; height: 2
                y: 108
                color: "#fff"
            }
        }

        TextField {
            id: password
            Layout.topMargin: 30
            placeholderText: "Insert PIN"
            font.pixelSize: 24
            style: TextFieldStyle {
                textColor: "#fff"
                placeholderTextColor: "#999"
                background: Rectangle {
                    implicitWidth: 490
                    implicitHeight: 110
                    color: "transparent"
                }
            }
            Rectangle {
                width: 490; height: 2
                y: 108
                color: "#fff"
            }
        }

        Text {
            id: error_msg
            color: "#D8746E"
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            Layout.topMargin: 30
            font.pixelSize: 18
        }

        Button {
            Layout.topMargin: 30
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 490
                    implicitHeight: 120
                    border.width: 2
                    border.color: "#fff"
                    color: btn_hover.containsMouse ? "#121212" : "transparent"
                    radius: 6
                }

                label: Text {
                    text: "Log In"
                    color: "#fff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 24
                }
            }

            MouseArea {
                id: btn_hover
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked:authorization(username.text, password.text)
            }
        }
    }
}
