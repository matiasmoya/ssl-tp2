class GrammarChecker
  attr_accessor :tipo, :gramatica

  def initialize(grammar)
    @tipo = 0
    @gramatica = grammar
  end

  def check
    gramatica.each do |line|
      @izquierda = line.split(" ")[0]
      @derecha   = line.split(" ")[1]

      next unless @izquierda.present? && @derecha.present?

      veriticar_tipo_1
      veriticar_tipo_2
      veriticar_tipo_3   
    end

    resultados[tipo]
  end

private
  
  def resultados
    [
      "Es una gramatica de tipo 0",
      "Es una gramatica de tipo 1",
      "Es una gramatica de tipo 2",
      "Es una gramatica de tipo 3",
      "Es una gramatica de tipo 3 por derecha",
      "Es una gramatica de tipo 3 por izquierda"
    ]
  end

  def veriticar_tipo_1
    if es_tipo_1? && !es_tipo_2?
      @tipo = 1 if @tipo < 1
    end
  end

  def veriticar_tipo_2
    if es_tipo_1? && es_tipo_2? && no_es_tipo_3
      @tipo = 2 if @tipo < 2
    end
  end

  def veriticar_tipo_3
    if es_tipo_1? && es_tipo_2?
      if (@derecha.size > 1) && es_tipo_3_por_derecha?
        @tipo = 4
      elsif (@derecha.size > 1) && es_tipo_3_por_izquierda?
        @tipo = 5
      else
        @tipo = 3 if es_tipo_3?
        @tipo = 2 if not es_tipo_3?
      end
    end
  end

  def es_tipo_1?
    return true if @derecha.size >= @izquierda.size
  end

  def es_tipo_2?
    if @izquierda.size == 1
      return @izquierda.is_upper?
    end
  end

  def es_tipo_3?
    return @derecha.size == 1 && @derecha.is_lower?
  end

  def es_tipo_3_por_derecha?
    @derecha.each_char.with_index do |char, i| 
      if char.is_upper? 
        if @derecha[i-1]&.is_lower?
          return true
        end
      end
    end

    return false
  end

  def es_tipo_3_por_izquierda?
    @derecha.each_char.with_index do |char, i|
      if char.is_upper?
        if @derecha[i+1]&.is_lower?
          return true
        end
      end
    end

    return false
  end

  def no_es_tipo_3
    not (es_tipo_3? || es_tipo_3_por_derecha? || es_tipo_3_por_izquierda?)
  end
end
