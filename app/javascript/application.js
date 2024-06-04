// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"

// 画像入力フォームプレビュー処理
document.addEventListener("DOMContentLoaded", function() {
  const imageInput = document.getElementById('image-input');
  const imagePreview = document.getElementById('image-preview');

  imageInput.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        imagePreview.innerHTML = `<img src="${e.target.result}" alt="Image Preview" style="max-width: 300px;">`;
      }
      reader.readAsDataURL(file);
    } else {
      imagePreview.innerHTML = '';
    }
  });
});
