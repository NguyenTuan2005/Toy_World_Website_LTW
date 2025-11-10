const sidebar = document.getElementById('sidebar');
const mainContent = document.getElementById('mainContent');

function collapseSidebar() {
    if (sidebar.classList.contains('collapsed')) {
        sidebar.classList.remove('collapsed');
        sidebar.classList.add('closed');
        mainContent.classList.add('full-width');
        document.getElementById('openSidebarBtn').classList.remove('d-none');
    } else {
        sidebar.classList.add('collapsed');
        mainContent.classList.remove('col-lg-9');
        mainContent.classList.add('col-lg-11');
    }
};

function closeSidebar() {
    sidebar.classList.remove('collapsed');
    sidebar.classList.add('closed');
    mainContent.classList.add('full-width');
    mainContent.classList.remove('col-lg-11');
    mainContent.classList.add('col-lg-9');
    document.getElementById('openSidebarBtn').classList.remove('d-none');
};

function openSidebar() {
    sidebar.classList.remove('closed');
    sidebar.classList.remove('collapsed');
    mainContent.classList.remove('full-width');
    document.getElementById('openSidebarBtn').classList.add('d-none');
};