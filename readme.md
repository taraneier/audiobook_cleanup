# Cleaning up audiobook mp3 files


1. rip with iTunes
2. copy files to work folder
3. run this to build filelist
``` ls -1 > files.csv ```
4. open files.csv in numbers.app or spreadsheet of your choice
	5. adjust settings to use non-existent comma as delimiter to avoid broken filenames
	6. manually edit rows into logical order
		7. delete . and ..
		8. deal with 1, 10, 11 type issues
	9. populate chapter column with chapter number on rows where chapters start
	9. populate filename column with a formula similar to this
	``` IF(ISBLANK(B4),C3,CONCATENATE("Chapter_",RIGHT("0"&B4,2), ".mp3")) ```
		1. add leading zero
		2. add .mp3
		3. repeat until new chapter marked
	10. finish with table with columns filename, chapter, chapter_filename, empty for formatting
	11. export as files.csv
12. run build_book.sh from the parts folder
14. run tag_tracks.sh
15. rename output folder to title of book
16. copy to iTunes
17. copy to archive

//TODO: deal with artwork
