module CommonRb
  class ModuleDefinition
    attr_reader :path
    attr_accessor :exports

    def initialize(path)
      @path = path
      @exports = {}
    end

    def respond_to?(method)
      @exports.include?(method) || method.to_s.end_with?('=')
    end

    def method_missing(method, *args)
      if method.to_s.end_with?('=')
        @exports[method] = args.first
      elsif @exports.include?(method)
        @exports[method]
      else
        raise NoMethodError, "no method #{method} on #{self}"
      end
    end

    def define_class(superclass = nil, &block)
      sc = superclass ? [superclass] : []

      Class.new(*sc) do
        singleton_class.send(:define_method, :attach) do |methods|
          methods.each_pair do |method, value|
            define_method(method) { value }
            singleton_class.send(:define_method, method) { value }
          end
        end

        class_eval(&block)
      end
    end
  end

  class << self
    def define(deps = [])
      path = caller_locations(1, 1)[0].absolute_path
      deps = load_deps(deps)

      modules[path] = begin
        ModuleDefinition.new(path).tap do |definition|
          yield definition, *deps
        end
      end
    end

    def require(deps)
      yield *load_deps(deps)
    end

    private

    def load_deps(deps)
      deps.map do |dep|
        path = dep_path(dep)
        Kernel.require(path)
        modules[path]
      end
    end

    # this will need to be waaaaaay smarter if we want
    # to be able to handle everything on the load path
    def dep_path(dep)
      File.expand_path(dep) + '.rb'
    end

    def modules
      @modules ||= {}
    end
  end
end
