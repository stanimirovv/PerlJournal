PerlJournal
===========

Small perl based journal / logger.

<h1>Installation</h1>
use "install.sh" to install

<h1>List of commands:</h1>
<h2>add</h2>  
<p>Creates a new entry in the journal.</p>
<p>
Sample usage: <br/>
add 'Today I learned how to bake cake'<br/>
add Today I learned   how to bake cake<br/>

<b>Note:</b> If you chose the second approach, additional spaces will be ignored.
I recommend using the first one.
</p>

<h2>get</h2>  
<p>Lists all lines where one of the keywords / substrings is found</p>
<p>
Sample usage: <br/>
get Alice<br/>
add Alice Bob<br/>

<b>Note:</b> It will print all entries where either one of them is written.</b>
</p>

<h2>getn</h2>  
<p>Lists all lines where all of the keywords / substrings are found</p>
<p>
Sample usage: <br/>
get Alice<br/>
add Alice Bob<br/>
</p>


<h2>rmv</h2>  
<p>Removes all lines where all of the keywords / substrings are found</p>
<p>
Sample usage: <br/>
get Alice<br/>
add Alice Bob<br/>
<b>Note:</b> Can't be undone.</b>
</p>


<h2>rmvn</h2>  
<p>Removes all lines where all of the keywords / substrings are found</p>
<p>
Sample usage: <br/>
get Alice<br/>
add Alice Bob<br/>
<b>Note:</b> Can't be undone.</b>
</p>


<h2>list</h2>  
<p>Lists all words starting with @</p>
<p>
Sample usage: <br/>
list <br/>
</p>
<p>
  Consider all the words starting with @ Special in the sense that you can retrieve them
  at any point, so I highly recommend that all entries contain at least one word starting with @.
  This will ease searching for information about specific topics.
</p>

<h1>Additional information </h1>
<p>An Alias is created which is prnl, so when you want to use the journal simply use:<br/>
prnl <command> <arguments> <br/>
Note: You have to restart your terminal or reload the bashrc in order for the alias to appear.
</p>

<p>
Every entry starts with a timestamp in miliseconds.
</p>
