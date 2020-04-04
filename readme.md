# Cleaning up audiobook mp3 files

1. rip with iTunes
2. create a folder for the book
2. copy iTunes files to riptracks folder
2. copy cover image in jpg format to cover folder
3. run this to build filelist
``` ls -1 > files.csv ```
4. open files.csv in numbers.app or spreadsheet of your choice
	1. adjust settings to use non-existent comma as delimiter to avoid broken filenames
	6. manually edit rows into logical order
		1. delete . and ..
		8. deal with 1, 10, 11 type issues
	9. populate chapter column with chapter number on rows where chapters start
	9. populate filename column with a formula similar to this
	``` IF(ISBLANK(B4),C3,CONCATENATE("Chapter_",RIGHT("0"&B4,2), ".mp3")) ```
		1. add leading zero
		2. add .mp3
		3. repeat until new chapter marked
	10. finish with table with columns filename, chapter, chapter_filename, empty for formatting
	11. export as files.csv
12. run build_book.sh with the following arguments
		1. the path of the folder created in step 2 above
		2. the proper title of the book in quotes
		3. for example:
		``` ./build_book.sh ~/Cuckoos_Calling/ "The Cuckoo's Calling" ```
15. rename output folder to title of book
16. copy to iTunes
17. copy to archive
