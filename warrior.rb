class Player

  def initialize
    @health = max_health
  end

  def play_turn(warrior)
    if !@not_first_movement
      @not_first_movement = true
      return warrior.pivot!
    end


    space = warrior.feel

    if warrior.look.any?(&:enemy?)
      warrior.shoot!
    elsif space.wall?
      warrior.pivot!
    elsif space.enemy?
      warrior.attack!
    elsif space.captive?
      warrior.rescue!
    elsif should_rest?(warrior)
      warrior.rest!
    elsif low_health?(warrior)
      warrior.walk!(:backward)
    else
      warrior.walk!
    end

    @health = warrior.health
  end

  def need_resting?(warrior)
    warrior.health < max_health
  end

  def taking_damage?(warrior)
    warrior.health < @health
  end

  def should_rest?(warrior)
    need_resting?(warrior) && ! taking_damage?(warrior)
  end

  def low_health?(warrior)
    warrior.health < 0.5 * max_health
  end

  def max_health
    20
  end
end

