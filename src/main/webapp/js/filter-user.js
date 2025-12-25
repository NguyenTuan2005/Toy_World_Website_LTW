document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("searchInput");

    if (!input) {
        console.error("❌ Không tìm thấy input #searchInput");
        return;
    }

    input.addEventListener("keydown", function (e) {
        if (e.key !== "Enter") return;

        e.preventDefault();

        const value = this.value.trim();
        if (!value) return;

        callSearch(detectKeyword(value));
    });

    function detectKeyword(value) {
        // userId (number)
        if (/^\d+$/.test(value)) {
            return { userId: value };
        }

        // email
        if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
            return { email: value };
        }

        // phone
        if (/^0\d{9,10}$/.test(value)) {
            return { phone: value };
        }

        // full name
        return { fullName: value };
    }

    function callSearch(params) {
        const query = new URLSearchParams(params);

        fetch(`/api/users/search?${query.toString()}`, {
            method: "GET",
            headers: {
                "Accept": "application/json"
            }
        })
            .then(res => {
                if (!res.ok) throw new Error("HTTP " + res.status);
                return res.json();
            })
            .then(data => {
                console.log(data);
                // render table ở đây
            })
            .catch(err => console.error("Search error:", err));
    }

});
