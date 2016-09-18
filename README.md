# Search Query Algorithm

## Summary
This program takes a document and a search query and returns the most relevant snippet from the document.

## My approach
This program starts by iterating through every character in the document, checking word by word to see if there is a match for one of the search query words. At the same time, it separates the document into sentences, keeping track of how many matching words exist in each sentence. This is translated into a search ranking. The more words a sentence has that match the search query, the higher its ranking.

Once this initial sweep is complete, the program creates snippets of text that match the search query in some way. Snippets contain one or multiple sentences. A snippet may contain a sentence that does not have any matching words as long as the sentences before and after it are related to the query. A snippet can become very long if there are many words in the search query and if the words exist in multiple sentences near each other.

The program checks the combined sentence search rankings within a snippet to decide which snippet to return from the given document. If two snippets have the same search ranking, the snippet appearing first in the document is returned.

The program does not currently support variations on search terms (i.e. the plural or singular version of a word).

## To Use
Tests can be found in the spec.rb file and can be run using ```rspec spec.rb```. Run the runner.rb file ```ruby runner.rb``` to launch a program in your terminal that will allow you to see an example search or provide your own document text and search query.
