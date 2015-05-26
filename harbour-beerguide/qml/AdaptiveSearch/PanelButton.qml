import QtQuick 2.0

BorderImage {
    signal clicked

    border {
        top: 10
        bottom: 10
        left: 10
        right: 10
    }
    source: buttonarea.pressed ? "../AdaptiveSearch/gfx/button_pressed.png" : "../AdaptiveSearch/gfx/button.png"

    MouseArea {
        id: buttonarea
        anchors.fill: parent
        onClicked: {
            parent.clicked();
        }
    }
}
