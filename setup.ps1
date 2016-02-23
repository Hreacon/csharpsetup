clear
Write-Host "Please enter a project name"
$project = Read-Host
Write-Host "Please enter pairs name"
$pair2 = Read-Host
$pair1 = "Nicholas Jensen"
Write-Host "Please enter database name"
$database = Read-Host

# Make directory structure
cd ..
mkdir $project | Out-Null
cd $project  | Out-Null
mkdir Content  | Out-Null
mkdir Content/css | Out-Null
mkdir Content/js | Out-Null
mkdir Modules  | Out-Null
mkdir Views  | Out-Null
mkdir Objects  | Out-Null
mkdir Tests  | Out-Null

# Copy unchanging files
copy ..\csharpsetup\cp\main\* . | Out-Null
copy ..\csharpsetup\cp\Views\* .\Views\ | Out-Null
copy ..\csharpsetup\cp\Content\css\* .\Content\css\ | Out-Null
copy ..\csharpsetup\cp\Content\js\* .\Content\js\ | Out-Null

# write files that need the project name in them

# HomeModule.cs
$file = "HomeModule.cs"
cd Modules | Out-Null
"using Nancy;" | Add-Content $file
"using "+$project + "NS.Objects;" | Add-Content $file
"using System.Collections.Generic;" | Add-Content $file

"namespace "+$project + "NS" | Add-Content $file
"{" | Add-Content $file
"  public class HomeModule : NancyModule" | Add-Content $file
"  {" | Add-Content $file
"    public HomeModule()" | Add-Content $file
"    {" | Add-Content $file
'      Get["/"] = _ => {' | Add-Content $file
'        return View["header.cshtml"];' | Add-Content $file
"      };" | Add-Content $file
"    }" | Add-Content $file
"  }" | Add-Content $file
"}" | Add-Content $file
cd .. | Out-Null


# Object.cs
cd Objects | Out-Null
$file = $project + ".cs"
"using System.Collections.Generic;" | Add-Content $file
"using System;" | Add-Content $file
'using System.Data;' | Add-Content $file
'using System.Data.SqlClient;' | Add-Content $file
'' | Add-Content $file
"namespace "+$project + "NS.Objects" | Add-Content $file
"{" | Add-Content $file
"  public class "+$project + "" | Add-Content $file
"  {" | Add-Content $file
"    public "+$project + "()" | Add-Content $file
"    {" | Add-Content $file
"    }" | Add-Content $file
"  } // end class" | Add-Content $file
"} // end namespace" | Add-Content $file

#Database.cs
$file = "Database.cs"
'using System.Data;' | Add-Content $file
'using System.Data.SqlClient;' | Add-Content $file
'' | Add-Content $file
'namespace ' + $project + 'NS' | Add-Content $file
'{' | Add-Content $file  
'  public class DB' | Add-Content $file
'  {' | Add-Content $file
'    public static SqlConnection Connection()' | Add-Content $file
'    {' | Add-Content $file
'      SqlConnection conn = new SqlConnection(DBConfiguration.ConnectionString);' | Add-Content $file
'      return conn;' | Add-Content $file
'    }' | Add-Content $file
'  }' | Add-Content $file
'}' | Add-Content $file
cd .. | Out-Null

cd Tests | Out-Null
# ObjectTest.cs
$file = $project + "Test.cs"
"using Xunit;" | Add-Content $file
"using "+$project+"NS.Objects;" | Add-Content $file
'using System.Collections.Generic;' | Add-Content $file
'using System;' | Add-Content $file
'using System.Data;' | Add-Content $file
'using System.Data.SqlClient;' | Add-Content $file
'' | Add-Content $file
"namespace "+$project+"NS" | Add-Content $file
"{" | Add-Content $file
"  public class "+$project+"Test : IDisposable" | Add-Content $file
"  {" | Add-Content $file
"     public "+$project+"Test()" | Add-Content $file
"     {" | Add-Content $file
'       DBConfiguration.ConnectionString = "Data Source=(localdb)\\mssqllocaldb;Initial Catalog='+$database+'_test;Integrated Security=SSPI;";' | Add-Content $file
"     }" | Add-Content $file
"     public void Dispose()" | Add-Content $file
"     {" | Add-Content $file
"       "+$project+".DeleteAll();" | Add-Content $file
"     }" | Add-Content $file
"  }" | Add-Content $file
"}" | Add-Content $file
cd .. | Out-Null

$file = "Startup.cs"
'using System.IO;' | Add-Content $file
'using Microsoft.AspNet.Builder;' | Add-Content $file
'using Nancy.Owin;' | Add-Content $file
'using Nancy;' | Add-Content $file
'using Nancy.ViewEngines.Razor;' | Add-Content $file
'using System.Collections.Generic;' | Add-Content $file
'' | Add-Content $file
'namespace $project'+'NS' | Add-Content $file
'{' | Add-Content $file
'  public class Startup' | Add-Content $file
'  {' | Add-Content $file
'    public void Configure(IApplicationBuilder app)' | Add-Content $file
'    {' | Add-Content $file
'      app.UseOwin(x => x.UseNancy());' | Add-Content $file
'    }' | Add-Content $file
'  }' | Add-Content $file
'  public class CustomRootPathProvider : IRootPathProvider' | Add-Content $file
'  {' | Add-Content $file
'    public string GetRootPath()' | Add-Content $file
'    {' | Add-Content $file
'      return Directory.GetCurrentDirectory();' | Add-Content $file
'    }' | Add-Content $file
'  }' | Add-Content $file
'  public class RazorConfig : IRazorConfiguration' | Add-Content $file
'  {' | Add-Content $file
'    public IEnumerable<string> GetAssemblyNames()' | Add-Content $file
'    {' | Add-Content $file
'      return null;' | Add-Content $file
'    }' | Add-Content $file
'' | Add-Content $file
'    public IEnumerable<string> GetDefaultNamespaces()' | Add-Content $file
'    {' | Add-Content $file
'      return null;' | Add-Content $file
'    }' | Add-Content $file
'' | Add-Content $file
'    public bool AutoIncludeModelNamespace' | Add-Content $file
'    {' | Add-Content $file
'      get { return false; }' | Add-Content $file
'    }' | Add-Content $file
'  }' | Add-Content $file
'  public static class DBConfiguration' | Add-Content $file
'  {' | Add-Content $file
'      public static string ConnectionString = "Data Source=(localdb)\\mssqllocaldb;Initial Catalog='+$database+';Integrated Security=SSPI;";' | Add-Content $file
'  }' | Add-Content $file
'}' | Add-Content $file

git init | Out-Null
if($pair2 -eq "self")
{
  $name = "Nicholas Jensen-Hay"
  $email = "nicholasjensenhay@gmail.com"
} else {
  $name = "$pair1 and $pair2"
  $email = "student@epicodus.com"
}
git config user.name $name | Out-Null
git config user.email $email | Out-Null
git add . | Out-Null
git commit -m "Initial Commit" | Out-Null

if(Test-Path "C:\Program Files (x86)\Microsoft VS Code\Code.exe")  {
  mkdir .vscode
  copy ..\csharpsetup\cp\vscode\* .\.vscode\
  code .
  $editor = "Visual Studio Code"
} else {
  $editor = "Atom"
    atom .
}
Write-Host "Please start working in $editor. Running DNU Restore in the background."


Write-Host "dnvm upgrade"
dnvm upgrade | Out-Null
Write-Host "dnvm upgrade complete."
Write-Host "dnu restore... please wait"
dnu restore | Out-Null
Write-Host "dnu restore complete."

Write-Host "Adding sql alias"
function openSql {sqlcmd -S "(localdb)\mssqllocaldb"}
New-Alias sql openSql