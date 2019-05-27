$(document).on("change", "#member_new_profile_picture", function(e) {
  let reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      let thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});

$(document).on("change", "#account_new_profile_picture", function(e) {
  let reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      let thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});

$(document).on("change", "#entry_image_new_data", function(e) {
  let reader;
  if (e.target.files.length) {
    reader = new FileReader;
    reader.onload = function(e) {
      let thumbnail;
      thumbnail = document.getElementById('thumbnail');
      thumbnail.setAttribute('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});
