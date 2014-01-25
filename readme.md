# BedSheetEfan

`BedSheetEfan` is a [Fantom](http://fantom.org) library that integrates [efan](http://www.fantomfactory.org/pods/afEfan) templates with the
[afBedSheet](http://www.fantomfactory.org/pods/afBedSheet) web framework.

`BedSheetEfan` provides a cache of your compiled [efan](http://www.fantomfactory.org/pods/afEfan) renderers, integrates into [afBedSheet](http://www.fantomfactory.org/pods/afBedSheet)'s Err 500 page and lets you contribute efan view helpers on an application level.



## Quick Start

xmas.efan:

    <% ctx.times |i| { %>
      Ho! 
    <% } %>
    Merry Christmas!


Fantom code:

    @Inject EfanTemplates efanTemplates

    ...

    // --> Ho! Ho! Ho! Merry Christmas!
    efanTemplates.renderFromFile(`xmas.fan`.toFile, 3)



## Documentation

Full API & fandocs are available on the [status302 repository](http://repo.status302.com/doc/afBedSheetEfan/#overview).



## Install

Download from [status302](http://repo.status302.com/browse/afBedSheetEfan).

Or install via fanr:

    $ fanr install -r http://repo.status302.com/fanr/ afBedSheetEfan

To use in a project, add a dependency in your `build.fan`:

    depends = ["sys 1.0", ..., "afBedSheetEfan 1.0+"]
