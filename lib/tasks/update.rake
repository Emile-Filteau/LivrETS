# encoding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'

namespace :update do
  desc "Update Programs. Create missing programs only."
  task programs: :environment do
    programs_info = {
      "SEG" => {:name => "Enseignement généraux", :color => '#000000'},
      "LOG" => {:name => "Génie logiciel", :color => '#000000'},
      "CTN" => {:name => 'Génie de la construction', :color => '#000000'},
      "ELE" => {:name => "Génie électrique", :color => '#000000'},
      "MEC" => {:name => "Génie mécanique", :color => '#000000'},
      "GPA" => {:name => "Génie de la production automatisée", :color => '#000000'},
      "GOL" => {:name => "Génie des opérations et de la logistique", :color => '#000000'},
      "GTI" => {:name => "Génie des technologies de l'information", :color => '#000000'},
    }
    programs = Hash[]
    programs_info.each do |acronym, program_info|
      program = Program.find_by(:acronym => acronym)
      if not program
        program = Program.create!(:acronym => acronym, :name => program_info[:name], :color => program_info[:color])
        puts "Created program #{acronym} (#{program_info[:name]})"
      end
      programs[acronym] = program
    end
  end

  desc "Update Courses. Create missing courses only."
  task courses: :environment do
    # The url where the courses list is available
    url = 'http://etsmtl.ca/Programmes-Etudes/Cours-horaires/Cours-horaires-1er-cycle/Cours-par-sigle?sigle=*'
    page = Nokogiri::HTML(open(url, "Accept-Encoding" => "inflate"))

    liste_cours_html = page.css('.ListeCoursGrille tr')
    liste_cours_html.each do |cours_html|
      acronym = cours_html.css('.ListeCoursGrilleCol1 a').text.strip
      name = cours_html.css('.ListeCoursGrilleCol2').text.strip
      if not Course.exists?(:acronym=>acronym)
        program_acronym = acronym[0..2]
        program = programs["SEG"]
        if programs.has_key?(program_acronym)
          program = programs[program_acronym]
        end
        course = Course.create!(:acronym => acronym, :name => name, :program => program)
        puts "Created course #{acronym} (#{name}) in program #{program.acronym}"
      end
    end
  end
end
