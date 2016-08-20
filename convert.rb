require "erb"
require "ostruct"

output = ""

projectname = ""
description = ""

projects = []

project_template = File.read("templates/project.html.erb")
index_template = File.read("templates/index.html.erb")

Dir["projects/*.project"].each do |name|
  output += File.read(name)
end

Dir["projects/*.description"].each do |name|
  content = File.read(name)
  title = content.split(";",2).first
  description = content.split(";",2).last
  projectname = name.split("/").last.split(".").first
  project_renderer = ERB.new(project_template)
  project_file = File.new("public/projects/#{projectname}.html","w")
  project_file.write(project_renderer.result())
  project_file.close()

  tuple = OpenStruct.new
  tuple.path = "public/projects/#{projectname}.html"
  tuple.name = projectname

  projects << tuple

end

index_renderer = ERB.new(index_template)
index_file = File.new("index.html","w")
index_file.write(index_renderer.result())
index_file.close()

file = File.new("public/packlist","w")
file.write(output)
file.close()
