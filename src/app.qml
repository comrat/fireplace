Item {
	anchors.fill: context;

	VideoPlayer {
		id: player;
		anchors.fill: parent;
		source: "fire.mp4";
		autoPlay: true;
		loop: true;
	}

	Rectangle {
		property bool show;
		width: 100%;
		height: 200s;
		anchors.bottom: parent.bottom;
		anchors.bottomMargin: 50s;
		opacity: show ? 1 : 0;

		ListView {
			width: 100%;
			height: 180s;
			contentX: currentIndex * (300s + spacing) - width / 2 + 150s;
			orientation: ListView.Horizontal;
			contentFollowsCurrentItem: false;
			animationDuration: 300;
			cssTranslatePositioning: true;
			spacing: 10s;
			model: ListModel {
				ListElement { url: "fire.mp4"; preview: "preview/fire.png"; }
				ListElement { url: "sea.mp4"; preview: "preview/sea.png"; }
			}
			delegate: Rectangle {
				height: 100%;
				width: 300s;
				color: "red";
				radius: 10s;
				clip: true;

				Image {
					anchors.fill: parent;
					source: model.preview;
				}
			}

			onSelectPressed: {
				player.source = this.model.get(this.currentIndex).url
			}

			onKeyPressed: {
				this.parent.showControls()
			}
		}

		Rectangle {
			y: -5s;
			width: 310s;
			height: 190s;
			anchors.horizontalCenter: parent.horizontalCenter;
			border.width: 3;
			border.color: "#fff";
		}

		Timer {
			id: displayTimer;
			interval: 3000;

			onTriggered: { this.parent.show = false }
		}

		showControls: {
			this.show = true
			displayTimer.restart()
		}

		Behavior on opacity { Animation { duration: parent.parent.animationDuration; easing: parent.parent.animationEasing; } }
	}
}
