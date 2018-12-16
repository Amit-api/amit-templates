<!doctype html>

<html lang="en">

<head>
  <meta charset="utf-8">
  <title>Service Index Doc</title>
  <meta name="description" content="The HTML5 Herald">

  <style>
    body {
      margin: 0;
      font-family: "Roboto", "Helvetica Neue", Helvetica, Arial, sans-serif;
      font-size: 1rem;
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

    a {
      color: #1997c6;
      text-decoration: none;
      background-color: transparent;
      -webkit-text-decoration-skip: objects;
    }

    a:hover {
      color: #106382;
      text-decoration: underline;
      cursor: pointer;
    }
  </style>
</head>

<body>
  <div class="bw">
    <h1>Service Doc Index</h1>
  </div>
  <ul>
<#list project.getServices() as service >
	<#assign serviceName = service.getName() >  
    <li>Service <a href="/doc/api/${serviceName?lower_case}">${serviceName}</a> doc</li>
</#list>    
  </ul>
</body>

</html>