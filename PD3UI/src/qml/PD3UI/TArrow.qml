import QtQuick 2.15
import QtQuick.Controls

Image {
    id: root
    source: "qrc:/public/arrow.png"
    visible: false
    width: 25
    height: 25
    function run() {
        visible = true;
        pathAnimation.start();
    }
    PathAnimation {
        id: pathAnimation
        target: root
        loops: -1
        duration: 2000
        orientation: PathAnimation.TopFirst
        path: Path {
            startX: Math.floor(Math.random() * 1200)
            startY: Math.floor(Math.random() * 769)
            PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}
            PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}
            PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}
            PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}
            PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}

            // startX: 0
            // startY: 100
            // PathCurve { x: 440; y: 440}
            // PathCurve { x: 740; y: 500}
            // PathCurve { x: 880; y: 440}
            // PathCurve { x: 880; y: 300}
            // PathCurve { x: 740; y: 180}
            // PathCurve { x: 540; y: 160}
            // PathCurve { x: 400; y: 300}
            // PathCurve { x: 420; y: 440}
            // PathCurve { x: 740; y: 500}
            // PathCurve { x: 880; y: 440}
            // PathCurve { x: Math.floor(Math.random() * 1200); y: Math.floor(Math.random() * 769)}
        }

        onRunningChanged: {
            // console.log("PathAnimation running: " + pathAnimation.running);
        }
    }
}
