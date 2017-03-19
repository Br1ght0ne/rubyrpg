module Numbers
  ENEMY_APPEAR_CHANCE = { Ghost: 70,
                          Ghoul: 50,
                          Dragon: 35,
                          Vampire: 50 }.freeze
  EXP_LEVELS = { 0..19 => 1,
                 20..49 => 2,
                 50..89 => 3,
                 90..139 => 4,
                 40..199 => 5 }.freeze
end
