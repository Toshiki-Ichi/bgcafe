document.addEventListener('DOMContentLoaded', function() {
  const pull_downButtons = document.querySelectorAll(".list_day");
  pull_downButtons.forEach(function (button) {
    button.addEventListener("click", () => {
      togglePullDown(button);
    });
  });

  const playTimeButtons = document.querySelectorAll(".play_time");
  playTimeButtons.forEach(function (button) {
    button.addEventListener("click", () => {
      togglePullDown(button);
    });
  });
});

// 表示・非表示を切り替える関数
function togglePullDown(button) {
  // クリックされたボタンの次にある.pull_down要素を取得
  const content = button.nextElementSibling;

  // pull_downクラスの要素かどうかを確認
  if (content && content.classList.contains("pull_down")) {
    // 表示・非表示を切り替える
    if (content.style.display === "none" || content.style.display === "") {
      content.style.display = "block"; // 表示する
    } else {
      content.style.display = "none"; // 非表示にする
    }
  }
}
