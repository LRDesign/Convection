require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::NpathComplexityMethodCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::NpathComplexityMethodCheck.new({'complexity' => 0}))
  end

  def verify_content_complexity(content, complexity)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"method_name\" n-path complexity is #{complexity}.  It should be 0 or less.")
  end
  
  it "should default to 1" do
    content = <<-END
    def method_name
    end
    END
    verify_content_complexity(content, 1)
  end
  
  it "should find an if block" do
    content = <<-END
    def method_name
      call_foo if some_condition
    end
    END
    verify_content_complexity(content, 2)
  end
  
  it "should find nested if block" do
    pending "NPath Complexity implementation that can support 'else' blocks"
    content = <<-END
    def method_name
      if (value1)
        foo
      else
        bar
      end
      if (value2)
        bam
      else
        baz
      end
      if (value3)
        one
      end
    end
    END
    verify_content_complexity(content, 8)
  end
end
