const sidebar = document.getElementById('sidebar');
const mainContent = document.getElementById('mainContent');

function collapseSidebar() {
    if (sidebar.classList.contains('collapsed')) {
        sidebar.classList.remove('collapsed');
        sidebar.classList.add('closed');
        mainContent.classList.add('w-100');
        document.getElementById('openSidebarBtn').classList.remove('d-none');
    } else {
        sidebar.classList.add('collapsed');
        mainContent.classList.remove('col-lg-10');
        mainContent.classList.add('flex-grow-1');
    }
};

// function closeSidebar() {
//     sidebar.classList.remove('collapsed');
//     sidebar.classList.add('closed');
//     mainContent.classList.add('w-100');
//     mainContent.classList.remove('flex-grow-1');
//     mainContent.classList.add('col-lg-10');
//     document.getElementById('openSidebarBtn').classList.remove('d-none');
// };

function openSidebar() {
    sidebar.classList.remove('closed');
    sidebar.classList.remove('collapsed');
    mainContent.classList.remove('w-100');
    document.getElementById('openSidebarBtn').classList.add('d-none');
};