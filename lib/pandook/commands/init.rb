desc 'Init a project'
arg_name 'path', [:multiple, :optional]
command :init do |c|
  c.desc "title of your project"
  c.flag [:T, :title]

  c.desc "Type of your project, options: book|article"
  c.flag [:t, :type]

  c.action do |global_options,options,args|
    help_now!("There should be a path.") if args.empty?
    help_now!("There should be only one path.") if args.length > 1

    DEFAULT_PANDOOK_YAML = <<EOF
---

title: #{options[:title] || "Title" }
type: #{options[:type] || "book" }
toc: true
lof: true
lot: true
content: []
pandoc:
  from:
  to:
  output:
  filter:
  smart: true
  filter:
  standalone:
  toc: true
  include-in-header:
  include-before-body:
  include-after-body:
  html5: true
  latex-engine: xelatex
  latex-engine-opts:
EOF

    DEFAULT_GITIGNORE = <<EOF
\#*
*~
*.swp
EOF

    path = args[0]

    if File.exists?(path) && (!File.directory?(path) || !(Dir.entries(path) - %w(. ..)).empty?)
      raise "Path #{path} exists, please specify another path."
    end

    FileUtils.mkdir_p(path)
    FileUtils.cd(File.join(path)) do
      FileUtils.mkdir_p('content')
      FileUtils.mkdir_p('output')
      File.write('pandook.yaml', DEFAULT_PANDOOK_YAML)
      File.write('.gitignore', DEFAULT_GITIGNORE)

      `git init .`
      `git add .gitignore pandook.yaml`
      `git commit -m "Init by pandook(http://pandook.com)"`
    end

    puts "Created a blank pandook project at '#{path}'. Enjoy!"
  end
end
