$(document).on("change", "#member_new_profile_picture", function(e) {
  var reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      var thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});

$(document).on("change", "#account_new_profile_picture", function(e) {
  var reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      var thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});

$(document).on("change", "#entry_image_new_data", function(e) {
  var reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      var thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});
