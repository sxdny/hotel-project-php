let btnAvatar = document.getElementById('btn-avatar');
let avatar = document.getElementById('avatar');

btnAvatar.addEventListener('change', function (event) {
    console.log("change");
    var reader = new FileReader();
    reader.onload = function () {
        var output = avatar;
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});