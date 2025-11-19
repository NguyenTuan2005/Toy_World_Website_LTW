$(document).ready(function () {
    $('.sortable').on('click', function () {
        const column = $(this).data('column');
        const icon = $(this).find('i');

        $('.sortable i').removeClass('fa-sort-up fa-sort-down').addClass('fa-sort text-white');

        if (icon.hasClass('fa-sort') || icon.hasClass('fa-sort-down')) {
            icon.removeClass('fa-sort fa-sort-down text-white').addClass('fa-sort-up text-white');
            console.log('Sắp xếp tăng dần theo cột:', column);
        } else {
            icon.removeClass('fa-sort-up text-white').addClass('fa-sort-down text-white');
            console.log('Sắp xếp giảm dần theo cột:', column);
        }
    });

    $('#searchInput').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        console.log('Tìm kiếm:', searchTerm);
    });

    $('#btnAddUser').on('click', function () {
        $('#userModalLabel').text('Thêm người dùng mới');
        $('#userForm')[0].reset();
        $('#status').prop('checked', true);
    });

    $('.btn-edit').on('click', function () {
        $('#userModalLabel').text('Chỉnh sửa người dùng');
        $('#userModal').modal('show');
        $('#userModalPassword').hide();
        console.log('Sửa người dùng');
    });

    $('.btn-delete').on('click', function () {
        if (confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
            console.log('Xóa người dùng');
        }
    });

    $('#btnSaveUser').on('click', function () {
        if ($('#userForm')[0].checkValidity()) {
            console.log('Lưu người dùng');
            $('#userModal').modal('hide');
        } else {
            $('#userForm')[0].reportValidity();
        }
    });
});