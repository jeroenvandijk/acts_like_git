require 'acts_like_git/model_init/builder'

module ActsLikeGit
  # 
  class ModelInit
    attr_accessor :versioned_fields, :versioned_fields_values, :repository, :root_repository, :table_name
    attr_accessor :versioned_fields, :repository, :root_repository, :table_name
    
    # TODO: document me
    #
    def initialize(model, &block)
      @root_repository, @repository = "", ""
      @table_name = model.name.tableize
      
      initialize_from_builder( &block ) if block_given?
    end
    
    # TODO: document this
    #
    def initialize_from_builder(&block)
      builder = Class.new(Builder)
      builder.setup(@table_name)
      
      builder.instance_eval( &block )
      
      @versioned_fields_values = {}
      @versioned_fields = builder.versioned_fields
      @repository       = "#{builder.repository}/#{@table_name}"
    end
  end
end