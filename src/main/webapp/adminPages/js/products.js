document.addEventListener('DOMContentLoaded', function() {
    function loadPage(page) {
        if (page < 1 || page > totalPages) return;

        fetch(contextPath + "/admin/products?page=" + page, {
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => {
                if (!response.ok) throw new Error('Mạng không thể kết nối');
                return response.text();
            })
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');

                const newTbody = doc.getElementById('productTableBody');
                document.getElementById('productTableBody').innerHTML = newTbody.innerHTML;

                const newPagination = doc.getElementById('productPagination');
                document.getElementById('productPagination').innerHTML = newPagination.innerHTML;

                const newPageInfo = doc.getElementById('pageInfo');
                document.getElementById('pageInfo').textContent = newPageInfo.textContent;

                attachPaginationListeners(page);
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi tải trang');
            });
    }

    function attachPaginationListeners(currentPage) {
        const pagination = document.getElementById('productPagination');
        const links = pagination.getElementsByTagName('a');

        links[0].addEventListener('click', (e) => {
            e.preventDefault();
            if (!links[0].parentElement.classList.contains('disabled')) {
                loadPage(1);
            }
        });

        links[1].addEventListener('click', (e) => {
            e.preventDefault();
            if (!links[1].parentElement.classList.contains('disabled')) {
                loadPage(currentPage - 1);
            }
        });

        for (let i = 2; i < links.length - 2; i++) {
            links[i].addEventListener('click', (e) => {
                e.preventDefault();
                const page = parseInt(links[i].textContent);
                loadPage(page);
            });
        }

        links[links.length - 2].addEventListener('click', (e) => {
            e.preventDefault();
            if (!links[links.length - 2].parentElement.classList.contains('disabled')) {
                loadPage(currentPage + 1);
            }
        });

        links[links.length - 1].addEventListener('click', (e) => {
            e.preventDefault();
            if (!links[links.length - 1].parentElement.classList.contains('disabled')) {
                loadPage(totalPages);
            }
        });
    }

    const initialPage = parseInt(document.getElementById("productPagination").getAttribute("data-current-page"));
    attachPaginationListeners(initialPage);
});

function showAlert(message) {
    const alert = document.getElementById('alert');
    alert.textContent = message;
    alert.classList.remove('d-none');
    setTimeout(() => alert.classList.add('d-none'), 3000);
}