# encoding: utf-8
# Script to get the list of courses from etsmtl.ca
require 'rake'

Rake::Task['update:programs'].invoke
Rake::Task['update:courses'].invoke
