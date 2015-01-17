# Script to get the list of courses from etsmtl.ca
# Ugly, but it works... for now.

source = `curl http://www.etsmtl.ca/Programmes-Etudes/Cours-horaires/Cours-horaires-1er-cycle/Cours-par-sigle?sigle=*`

listCoursesSource = source.split('<table class="ListeCoursGrille" cellspacing="0" cellpadding="0" border="0" id="plc_lt_zoneMain_pageplaceholder_pageplaceholder_lt_zoneContent_pageplaceholder_pageplaceholder_lt_zoneCenter_pageplaceholder_pageplaceholder_lt_zoneCenter_ListeCoursParSigle_GridViewResultats" style="border-collapse:collapse;">')[1].split('</table>')[0];

listCoursesAcronyms = listCoursesSource.scan(/Fiche-de-cours\?Sigle=(.*)"/)
listCoursesNames = listCoursesSource.scan(/ListeCoursGrilleCol2">\s*(.*)\s*<\/td>/)

Program.delete_all
programs = Hash[]
programs["SEG"] = Program.create!(:acronym => 'SEG', :name => 'Enseignement généraux', :color => '#000000')
programs["LOG"] = Program.create!(:acronym => 'LOG', :name => 'Génie logiciel', :color => '#000000')
programs["CTN"] = Program.create!(:acronym => 'CTN', :name => 'Génie de la construction', :color => '#000000')
programs["ELE"] = Program.create!(:acronym => 'ELE', :name => 'Génie électrique', :color => '#000000')
programs["MEC"] = Program.create!(:acronym => 'MEC', :name => 'Génie mécanique', :color => '#000000')
programs["GPA"] = Program.create!(:acronym => 'GPA', :name => 'Génie de la production automatisée', :color => '#000000')
programs["GOL"] = Program.create!(:acronym => 'GOL', :name => 'Génie des opérations et de la logistique', :color => '#000000')
programs["GTI"] = Program.create!(:acronym => 'GTI', :name => 'Génie des technologies de l\'information', :color => '#000000')

Course.delete_all
listCoursesAcronyms.zip( listCoursesNames ).each do |acronym,name|
  acronym = acronym[0].strip
  name = name[0].strip
  program_acronym = acronym[0..2]
  program = programs["SEG"]
  if programs.has_key?(program_acronym)
    program = programs[program_acronym]
  end
  course = Course.create!(:acronym => acronym, :name => name, :program => program)
  puts "Created course #{acronym} (#{name}) in program #{program.acronym}"
end