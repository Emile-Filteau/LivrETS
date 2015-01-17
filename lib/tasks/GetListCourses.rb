# Script to get the list of courses from etsmtl.ca
# Ugly, but it works... for now.

source = `curl http://www.etsmtl.ca/Programmes-Etudes/Cours-horaires/Cours-horaires-1er-cycle/Cours-par-sigle?sigle=*`

listCoursesSource = source.split('<table class="ListeCoursGrille" cellspacing="0" cellpadding="0" border="0" id="plc_lt_zoneMain_pageplaceholder_pageplaceholder_lt_zoneContent_pageplaceholder_pageplaceholder_lt_zoneCenter_pageplaceholder_pageplaceholder_lt_zoneCenter_ListeCoursParSigle_GridViewResultats" style="border-collapse:collapse;">')[1].split('</table>')[0];

listCoursesAcronyms = listCoursesSource.scan(/Fiche-de-cours\?Sigle=(.*)"/)
listCoursesNames = listCoursesSource.scan(/ListeCoursGrilleCol2">\s*(.*)\s*<\/td>/)

Course.delete_all
listCoursesAcronyms.zip( listCoursesNames ).each do |acronym,name|
  acronym = acronym[0].strip
  name = name[0].strip
  Course.create!(:acronym => acronym, :name => name)
  puts "Created course #{acronym} (#{name})"
end