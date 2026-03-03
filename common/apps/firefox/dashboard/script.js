const LINKS = [
    { name: 'Canvas', url: 'https://instructure.charlotte.edu', icon: 'fas fa-graduation-cap', color: '#046A38' },
    { name: 'Gmail', url: 'https://mail.google.com', icon: 'fas fa-envelope', color: '#ea4335' },
    { name: 'Drive', url: 'https://drive.google.com', icon: 'fab fa-google-drive', color: '#1FA463' },
    { name: 'GitHub', url: 'https://github.com', icon: 'fab fa-github', color: '#ffffff' },
    { name: 'YouTube', url: 'https://youtube.com', icon: 'fab fa-youtube', color: '#ff0000' },
    { name: 'Lobste.rs', url: 'https://lobste.rs', icon: 'fas fa-fish', color: '#ac130d' },
    { name: 'Hacker News', url: 'https://news.ycombinator.com', icon: 'fab fa-hacker-news-square', color: '#ff6600' },
];

const URL_REGEX = /^((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)$/i;

function getTimeOfDay(hour) {
    if (hour >= 5 && hour < 12) return 'morning';
    if (hour >= 12 && hour < 17) return 'afternoon';
    if (hour >= 17 && hour < 22) return 'evening';
    return 'night';
}

function updateClock() {
    const now = new Date();
    const hh = String(now.getHours()).padStart(2, '0');
    const mm = String(now.getMinutes()).padStart(2, '0');

    document.getElementById('clock').textContent = `${hh}:${mm}`;

    const greeting = `Good ${getTimeOfDay(now.getHours())}, Skip.`;
    const greetingEl = document.getElementById('greeting');

    if (greetingEl.textContent !== greeting) {
        greetingEl.textContent = greeting;
        greetingEl.animate(
            [{ opacity: 0, transform: 'translateY(-10px)' },
            { opacity: 1, transform: 'translateY(0)' }],
            { duration: 500, easing: 'ease-out', fill: 'forwards' }
        );
    }
}

function startClock() {
    updateClock();
    const now = new Date();
    const msUntilNextMinute = (60 - now.getSeconds()) * 1000 - now.getMilliseconds();
    setTimeout(() => {
        updateClock();
        setInterval(updateClock, 60_000);
    }, msUntilNextMinute);
}

function renderLinks() {
    const fragment = document.createDocumentFragment();
    for (const { name, url, icon, color } of LINKS) {
        const a = document.createElement('a');
        a.href = url;
        a.className = 'link-card';
        a.style.setProperty('--hover-color', color);
        a.innerHTML = `<div class="icon-wrapper"><i class="${icon}"></i></div>
                       <span class="link-title">${name}</span>`;
        fragment.appendChild(a);
    }
    document.getElementById('links-grid').appendChild(fragment);
}

function handleSearch(e) {
    const val = e.target.querySelector('input').value.trim();
    if (URL_REGEX.test(val)) {
        e.preventDefault();
        window.location.href = val.startsWith('http') ? val : `https://${val}`;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    renderLinks();
    startClock();
    document.getElementById('search-form').addEventListener('submit', handleSearch);
});
