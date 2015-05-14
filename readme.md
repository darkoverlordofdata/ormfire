# ormfire
        
            )              (                 
         ( /(              )\ )              
         )\()) (      )   (()/( (  (     (   
        ((_)\  )(    (     /(_)))\ )(   ))\  
          ((_)(()\   )\  '(_))_((_|()\ /((_) 
         / _ \ ((_)_((_)) | |_  (_)((_|_))   
        | (_) | '_| '  \()| __| | | '_/ -_)  
         \___/|_| |_|_|_| |_|   |_|_| \___|  
                                             
                lite orm for firebase        
        

Use sequelize interface to work with firebase

* Use sequelize to create scaffolds
+ Add firebase property to ./db/config/config.json
+ Create ./db/models.coffee (see example)
+ Migrate data
+ require('ormfire')

Models with an autoincrement id field are written to database using push
Other models use update to write to the database.


# MIT License

Copyright (c) 2015 Bruce Davidson &lt;darkoverlordofdata@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
