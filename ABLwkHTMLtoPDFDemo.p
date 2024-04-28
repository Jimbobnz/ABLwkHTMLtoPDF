
/*------------------------------------------------------------------------
    File        : ABLwkHTMLtoPDFDemo.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : james
    Created     : Sun Apr 28 17:00:48 NZST 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


block-level on error undo, throw.

define stream sContent.
define stream sOSCommnad.

define variable wkHTMLtoPDInstall as character no-undo initial "C:\Program Files\wkhtmltopdf".
define variable wkHTMLtoPDExec    as character no-undo initial "bin\wkhtmltopdf.exe".
define variable wkHTMLOutput      as character no-undo initial "HTMLOutput.html".
define variable wkPDFOutput       as character no-undo initial "HTMLOutput.pdf".


/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define OUT put stream sContent unformatted


/* ***************************  Main Block  *************************** */

run GenerateHTML in this-procedure.
run ConverHTMLtoPDF in this-procedure.


/* **********************  Internal Procedures  *********************** */

procedure ConverHTMLtoPDF private:
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    define variable OSCommand     as character no-undo.
    define variable GlobalOptions as character no-undo.
    
    define variable standardInput as character no-undo.
    
    
    

    GlobalOptions = "--page-size A4 --enable-local-file-access".

    OSCommand = substitute('"&1\&2" &3 &4 &5', wkHTMLtoPDInstall, wkHTMLtoPDExec, GlobalOptions, wkHTMLOutput,  wkPDFOutput).

    message OSCommand.

    input-output stream sOSCommnad through value(OSCommand).
    
    repeat:
        
        import stream sOSCommnad unformatted standardInput. 
        
        message standardInput.
        
    end.
    
    input-output stream sOSCommnad close.    

end procedure.

procedure GenerateHTML private:
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    output stream sContent to value(wkHTMLOutput).

    {&OUT} 
        '<!DOCTYPE html>' skip.
    {&OUT}         
        '<html lang="en">' skip.
    {&OUT}         
        '<head>' skip.
    {&OUT}         
        '    <meta charset="UTF-8">' skip.
    {&OUT}         
        '    <meta name="viewport" content="width=device-width, initial-scale=1.0">' skip.
    {&OUT}         
        '    <title>SVG Logo in HTML</title>' skip.
    {&OUT}         
        '    <style>' skip.
    {&OUT}         
        '        body ~{' skip.
    {&OUT}         
        '            margin: 0;' skip.
    {&OUT}         
        '            padding: 0;' skip.
    {&OUT}         
        '            font-family: Arial, sans-serif;' skip.
    {&OUT}         
        '        }' skip.
    {&OUT}         
        '        .logo ~{' skip.
    {&OUT}         
        '            position: absolute;' skip.
    {&OUT}         
        '            top: 10px;' skip.
    {&OUT}         
        '            right: 10px;' skip.
    {&OUT}         
        '            width: 100px; /* Adjust the width and height as needed */' skip.
    {&OUT}         
        '            height: auto;' skip.
    {&OUT}         
        '        }' skip.
    {&OUT}         
        '    </style>' skip.
    {&OUT}         
        '</head>' skip.
    {&OUT}         
        '<body>' skip.
    {&OUT} 
        '<h1> ABL PDF Generated Document </h1>' skip.    
            
    {&OUT} 
        substitute('<img alt="SVG Logo" class="logo" src="&1"/>', "SVGLogo.svg")  skip.       
            
    {&OUT} '<hr/>' skip.
    
    {&OUT} '<ul>' skip.
    
    {&OUT} '<li>' iso-date(now) '</li>' skip.
    
    {&OUT} '<li>' Session:temp-directory '</li>' skip.
    
    {&OUT} '<li>' PROGRESS PROVERSION(1)  '</li>' skip.
    
    {&OUT} '</ul>' skip.
    {&OUT}         
        '</body>' skip.
    {&OUT}         
        '</html>' skip.

    output stream sContent Close.


end procedure.




