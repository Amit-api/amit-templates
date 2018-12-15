<#assign objectName = object.getName() >
<!doctype html>

<html lang="en">

<head>
  <meta charset="utf-8">
  <title>Service ${objectName} Doc</title>
  <meta name="description" content="The HTML5 Herald">

  <style>
    body {
      margin: 0;
      font-family: "Roboto", "Helvetica Neue", Helvetica, Arial, sans-serif;
      font-size: 0.9rem;
      font-weight: 300;
      line-height: 1.5;
      color: #cfd2da;
      text-align: left;
      background-color: #252830;
    }

    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
      margin-bottom: 0.5rem;
      font-family: inherit;
      font-weight: 300;
      line-height: 1.2;
      color: white;
    }

    h1 {
      font-size: 2.5rem;
    }

    h2 {
      font-size: 2rem;
    }

    h3 {
      font-size: 1.75rem;
    }

    h4 {
      font-size: 1.5rem;
    }

    h5 {
      font-size: 1.25rem;
    }

    h6 {
      font-size: 1rem;
    }

    .bw {
      width: 100%;
      padding-right: 10px;
      padding-left: 10px;
      margin-right: auto;
      margin-left: auto;
    }

    @media (min-width: 768px) {
      .bw {
        max-width: 880px;
      }
    }

    @media (min-width: 992px) {
      .bw {
        max-width: 950px;
      }
    }

    @media (min-width: 1200px) {
      .bw {
        max-width: 1100px;
      }
    }

    textarea,
    pre {
      display: block;
      font-size: 90%;
      color: #999;
      background-color: #1a1c22;
      font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
      border: 0px solid #e5e5e5;
    }

    .bs {
      position: relative;
      padding: 20px;
      margin: 20px -15px;
      font-size: 14px;
      border: 1px solid #e5e5e5;
      background: #fff;
    }

    .bs::after {
      display: block;
      clear: both;
      content: "";
    }

    .bs+.br {
      margin-top: -20px;
    }

    @media (min-width: 576px) {
      .bs {
        margin-left: 0;
        margin-right: 0;
        border-radius: 3px 3px 0 0;
      }
    }

    .bs+p {
      margin-top: 30px;
    }

    .bs>*:last-child {
      margin-bottom: 0;
    }

    .bs .bw {
      width: auto;
    }

    .bs>.dropdown-menu:first-child {
      position: static;
      display: block;
    }

    .bs>.by {
      max-width: 300px;
    }

    @media (min-width: 576px) {
      .bs .bz {
        display: inline-block;
        margin: 5px;
      }
    }

    .bs {
      position: relative;
      padding: 20px;
      margin: 20px 0px;
      font-size: 14px;
      border: 1px solid #e5e5e5;
      background: #fff;
      background-color: transparent;
      border-color: #434857;
    }

    .ni {
      color: #fff;
      background-color: #1997c6;
      border-color: #1997c6;
    }

    .ni:hover {
      color: #fff;
      background-color: #157da4;
      border-color: #137499;
    }

    .ni:focus,
    .ni.nh {
      box-shadow: 0 0 0 0.2rem rgba(25, 151, 198, 0.5);
    }

    .ni.disabled,
    .ni:disabled {
      color: #fff;
      background-color: #1997c6;
      border-color: #1997c6;
    }

    .ni:not(:disabled):not(.disabled):active,
    .ni:not(:disabled):not(.disabled).active,
    .show>.ni.nj {
      color: #fff;
      background-color: #137499;
      border-color: #126c8d;
    }

    .ni:not(:disabled):not(.disabled):active:focus,
    .ni:not(:disabled):not(.disabled).active:focus,
    .show>.ni.nj:focus {
      box-shadow: 0 0 0 0.2rem rgba(25, 151, 198, 0.5);
    }


    .ce {
      display: inline-block;
      font-weight: normal;
      text-align: center;
      white-space: nowrap;
      vertical-align: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
      border: 1px solid transparent;
      padding: 0.375rem 0.75rem;
      font-size: 0.9rem;
      line-height: 1.5;
      border-radius: 0.25rem;
      -webkit-transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
      transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }

    .ce:hover,
    .ce:focus {
      text-decoration: none;
    }

    .ce:focus,
    .ce.nh {
      outline: 0;
      box-shadow: 0 0 0 0.2rem rgba(25, 151, 198, 0.25);
    }

    .ce.disabled,
    .ce:disabled {
      opacity: 0.65;
    }

    .ce:not(:disabled):not(.disabled) {
      cursor: pointer;
    }

    .ce:not(:disabled):not(.disabled):active,
    .ce:not(:disabled):not(.disabled).active {
      background-image: none;
    }

    .ahdr {
      font-size: 1rem;
      color: #1997c6;
    }
  </style>
</head>

<body>
  <div class="bw">
    <h2>Service <b>${objectName}</b> doc and playground</h2>
    <p>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
      magna
      aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
      consequat.
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
      sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    </p>
<#list object.getBaseInterfaceNames() as interfaceName > 
	<#assign ainterfaceName = interfaceName?uncap_first > 
	<#assign interfaceObj = project.getInterface( interfaceName ) >	
		<#list interfaceObj.getFunctions() as function >
		<#assign fname = function.getName() >
		<#assign url = "/api/" + objectName?lower_case +"/" + fname?lower_case >

    <h4>${fname} call</h4>
    <p>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
      magna
      aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
      consequat.
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    </p>

    <div class="bs">
      <div class="ahdr"><button id="${url}" class="ni ce dopost">POST : </button> ${url}</div>
      <p>
        Request Content:
        <textarea id="${url}:r" cols="80">
{
  "a": "asdas",
  "b": "ssf" 
}</textarea>
      </p>
      <p id="${url}:s" style="display: none;">
        Response Content:
        <textarea id="${url}:p" cols="80" readonly></textarea>
      </p>
    </div>
	</#list>
</#list>
  </div>
  <script>
    var tx = document.getElementsByTagName('textarea');
    for (var i = 0; i < tx.length; i++) {
      tx[i].setAttribute('style', 'height:' + (tx[i].scrollHeight) + 'px;overflow-y:hidden;');
      tx[i].addEventListener("input", OnInput, false);
    }

    function OnInput() {
      resize(this);
    }

    function display(path, message) {
      var result = document.getElementById(path + ":p");
      var section = document.getElementById(path + ":s");
      section.style.display = "block";
      result.value = message;
      resize(result);
    }

    function hide(path) {
      var result = document.getElementById(path + ":p");
      var section = document.getElementById(path + ":s");
      section.style.display = "none";
      result.value = "";
    }

    function resize(item) {
      item.style.height = 'auto';
      item.style.height = (item.scrollHeight) + 'px';
    }

    var bt = document.getElementsByClassName("dopost");
    for (var i = 0; i < bt.length; i++) {
      bt[i].addEventListener("click", OnPost, false)
    }

    function OnPost(event) {
      var url = event.target.id;      
      hide(url);

      var content = document.getElementById(url + ":r").value;
      if (content) {
        content = content.trim();
      } else {
        content = null;
      }
      var request = null;
      if (content != null) {
        try {
          request = JSON.parse(content);
        } catch( error ) {
          display(url, "Invalid request: " + error.message);
          return;
        }
      }

      fetch(url, {
        method: 'post',
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: request
      }).then(function(response){
		display(url, response);
      }).catch(function (error) {
        display(url, "call failed: " + error.message);
      });
    }


  </script>
</body>

</html>