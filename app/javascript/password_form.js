document.addEventListener('DOMContentLoaded', function() {
  // モーダルとボタンの取得
  const modal = document.getElementById("passwordModal");
  const closeButton = document.getElementsByClassName("close")[0]; // [0]で最初のcloseボタン取得
  const submitButton = document.getElementById("submitPassword");
  let currentRoomId = null; // クリックされたルームのIDを保持

  // すべてのパスワードリンクを取得
  const passwordLinks = document.querySelectorAll(".passwordLink");

  // 各リンクにイベントリスナーを追加
  passwordLinks.forEach(function(link) {
    link.addEventListener("click", function(event) {
      event.preventDefault(); // デフォルトのリンク動作を防ぐ
      currentRoomId = this.getAttribute("data-room-id"); // ルームIDを取得
      modal.style.display = "block"; // モーダルを表示
    });
  });

  // ×ボタンでモーダルを閉じる
  closeButton.onclick = function() {
    modal.style.display = "none";
  }

  // モーダル外をクリックした時に閉じる
  window.onclick = function(event) {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  }

  // パスワード送信の処理
  submitButton.onclick = function() {
		const password = document.querySelector(".roomPassword").value;
    // AJAXリクエストでパスワードをサーバーに送信
    fetch("/rooms/enter", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ password: password, room_id: currentRoomId }) // 現在のルームIDを送信
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // 入室成功の処理
        window.location.href = `/rooms/${currentRoomId}`; // ルームのページにリダイレクト
      } else {
        alert(data.message); // エラーメッセージの表示
      }
    })
    .catch(error => console.error('Error:', error));

    modal.style.display = "none"; // モーダルを閉じる
  }
});
