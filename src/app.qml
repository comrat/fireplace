Item {
	id: root;
	property string baseUrl: "https://comrat.github.io/fireplace/videos";
	anchors.fill: context;

	ClickMixin { }

	VideoPlayer {
		id: player;
		anchors.fill: parent;
		source: "https://comrat.github.io/fireplace/videos/fire1/index.m3u8";
		autoPlay: true;
		loop: true;
	}

	Rectangle {
		id: osd;
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
				ListElement { url: "https://comrat.github.io/fireplace/videos/fire1/index.m3u8"; preview: "https://github.com/comrat/fireplace/raw/content/preview/fire1.png"; }
				ListElement { url: "https://comrat.github.io/fireplace/videos/fire2/index.m3u8"; preview: "https://github.com/comrat/fireplace/raw/content/preview/fire2.png"; }
				ListElement { url: "https://comrat.github.io/fireplace/videos/fire3/index.m3u8"; preview: "https://github.com/comrat/fireplace/raw/content/preview/fire3.png"; }
			}
			delegate: Rectangle {
				height: 100%;
				width: 300s;
				color: "red";
				radius: 10s;
				clip: true;
				border.color: "#424242";
				border.width: delegateMixin.value && model.index != parent.currentIndex ? 5s : 0;
				border.type: Border.Outer;

				HoverClickMixin { id: delegateMixin; }

				Image {
					anchors.fill: parent;
					source: model.preview;
				}

				onClicked: {
					this.parent.currentIndex = model.index
					this.parent.playIndex(model.index)
				}
			}

			playIndex(idx): { player.source = this.model.get(idx).url }
			onSelectPressed: { this.playIndex(this.currentIndex) }

			onKeyPressed: {
				if (key == "Back")
					return false
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

	onBackPressed: {
		var os = this._context.system.os.toLowerCase()
		if (os == "webos")
			_globals.platformBack()
		else
			_globals.closeApp()
	}

	onClicked: { osd.showControls() }
}
