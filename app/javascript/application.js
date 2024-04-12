// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  setupMenuToggle();
  setupSearchToggle();
  setupUserMenuToggle();
});

function setupMenuToggle() {
  document.querySelector('#toggle').addEventListener('click', () => {
    document.querySelector('#menu').classList.toggle('hidden');
  });
}

function setupSearchToggle() {
  document.querySelector('#search-toggle').addEventListener('click', () => {
    document.querySelector('#search-content').classList.toggle('hidden');
  });
}

function setupUserMenuToggle() {
  document.querySelector('#user-menu-button').addEventListener('click', () => {
    document.querySelector('#user-menu-dropdown').classList.toggle('hidden');
  });
}
