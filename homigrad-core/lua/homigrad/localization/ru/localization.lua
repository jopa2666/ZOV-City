hg.Localizations = hg.Localizations or {}

hg.Localizations.ru = {}

table.Empty(hg.Localizations.ru)

local l = {}

// Текст Смерти
l.Dead = "МЁРТВ"
l.dead_blood = "Ты умер от потери крови."
l.dead_pain = "Ты умер от невыносимой боли."
l.dead_painlosing = "Ты упал спать."
l.dead_adrenaline = "Ты умер от передоза."
l.dead_kys = "Ты самоубился." 
l.dead_hungry = "Ты помер с голоду."
l.dead_neck = "Твоя шея была сломана."
l.dead_necksnap = "Твоя шея была свёрнута."
l.dead_world = "%s прощается с жестоким миром!"
l.dead_head = "Бум, в голову."
l.dead_headExplode = "Твоя голова была взорвана."
l.dead_fullgib = "Тебя разорвало."
l.dead_blast = "Ты взорвался."
l.dead_water = "Ты утонул."
l.dead_poison = "Ты умер от отравления."
l.dead_burn = "Ты сгорел заживо."
l.dead_unknown = "Я даже не знаю как ты умер то."

l["kill_ValveBiped.Bip01_Head1"] = "голову"
l["kill_ValveBiped.Bip01_Spine"] = "спину"
l["kill_ValveBiped.Bip01_Spine1"] = "спину"
l["kill_ValveBiped.Bip01_Spine2"] = "спину"
l["kill_ValveBiped.Bip01_Spine4"] = "спину"

l["kill_ValveBiped.Bip01_R_Hand"] = "правую руку"
l["kill_ValveBiped.Bip01_R_Forearm"] = "правую руку"
l["kill_ValveBiped.Bip01_R_UpperArm"] = "правый локоть"

l["kill_ValveBiped.Bip01_R_Foot"] = "правую ногу"
l["kill_ValveBiped.Bip01_R_Thigh"] = "правую ногу"
l["kill_ValveBiped.Bip01_R_Calf"] = "правую ногу"

l["kill_ValveBiped.Bip01_R_Shoulder"] = "правое плечо"
l["kill_ValveBiped.Bip01_R_Elbow"] = "правый локоть"

l["kill_ValveBiped.Bip01_L_Hand"] = "левую руку"
l["kill_ValveBiped.Bip01_L_Forearm"] = "левую руку"
l["kill_ValveBiped.Bip01_L_UpperArm"] = "левый локоть"

l["kill_ValveBiped.Bip01_L_Foot"] = "левую ногу"
l["kill_ValveBiped.Bip01_L_Thigh"] = "левую ногу"
l["kill_ValveBiped.Bip01_L_Calf"] = "левую"

l["kill_ValveBiped.Bip01_L_Shoulder"] = "левое плечо"
l["kill_ValveBiped.Bip01_L_Elbow"] = "левый локоть"

l["in"] = "в"
l.kill_by_wep = "с помощью"

l.died_by = "Тебя убил"
l.died = "Тебя убило"
l.died_killed = "Тебя убил"
l.died_by_npc = "Убил НИП"
l.died_by_object = "Убил предмет"

// Оружие
l.gun_revolver = "%s Пуль заряжено"
l.gun_revolvermags = "%s Пуль в запасе"

l.gun_shotgun = "%s"
l.gun_shotgunmags = "%s Патрон осталось"

l.gun_default = "%s"
l.gun_defaultmags = "%s Магазинов осталось"

l.gun_empty = "Пусто"
l.gun_nearempty = "Почти Пусто"
l.gun_halfempty = "На половину пуст"
l.gun_nearfull = "Почти полон"
l.gun_r_pump = "Нажми R чтобы передёрнуть затвор."
l.gun_full = "Полон" 

l.cuff = "Связать %s"
l.cuffed = "%s Уже связан."

// Спект
l.SpectALT = "Выключить / Включить отображение никнеймов на ALT"
l.SpectHP = "Здоровье: %s"
l.SpectCur = "Наблюдателей: %s"
l.SpectMode = "Режим наблюдателя: %s"

// Уровни

l.level_wins = "%s выиграли."  
l.levels_endin = "Раунд закончится через: %s"

l.swat_arrived = "Прибыл Спецназ."  
l.swat_arrivein = "Спецназ прибудет через: %s"  

l.police_arrived = "Прибыла полиция."  
l.police_arrivein = "Полиция прибудет через: %s"  

l.ng_arrived = "Прибыла Национальная гвардия."  
l.ng_arrivein = "Национальная гвардия прибудет через: %s"  

l.you_are = "Вы – %s"  
l.lvl_loadingmode = "Загружаем режим %s"

l.hunter_victim = "Жертвы"  
l.hunter_victim_desc = "Вы должны выжить. \n Спасайтесь, когда прибудет спецназ."  

l.hunter_swat = "Спецназовцы"  
l.hunter_swat_desc = "Вы должны нейтрализовать Охотника. \n Помогите выжившим сбежать."  

l.hunter_hunter = "Охотники"  
l.hunter_hunter_desc = "Ваша задача – убить всех до прибытия спецназа."

l.hunter_hunter = "Hunter"
l.hunter_hunter_desc = "Ваша задача убить всех до приезда "

l.dr_runner = "Бегуны"
l.dr_runner_desc = "Вам нужно завершить карту и убить \"Убийцу\""

l.dr_killer = "Убийцы"
l.dr_killer_desc = "Ваша задача убить всех используя ловушки на карте"
l.dr_youwilldiein = "Ты умрешь через: %s"

l.tdm_red = "Красные"  
l.tdm_red_desc = "Уничтожьте противоположную команду"

l.tdm_blue = "Синие"  
l.tdm_blue_desc = "Уничтожьте противоположную команду"  

l.riot_red = "Бунтующие"  
l.riot_red_desc = "Отстаивайте свои права! Уничтожьте всех, кто встанет у вас на пути!"  

l.riot_blue = "Полиция"  
l.riot_blue_desc = "Нейтрализуйте бунтовщиков, старайтесь не убивать их"  

l.hmcd_bystander = "Невиновные"  
l.hmcd_bystander_desc = "Вы невиновны, полагайтесь только на себя, но держитесь в толпе, чтобы усложнить задачу предателю."  

l.hmcd_gunman = "Вооружённый"  
l.hmcd_gunman_desc = "Вы невиновны, полагайтесь только на себя, но держитесь в толпе, чтобы усложнить задачу предателю."  

l.hmcd_traitor = "Предатели"  
l.hmcd_traitor_desc = "У вас есть снаряжение, яды, взрывчатка и оружие, спрятанное в карманах. Убейте всех здесь."  

l.hmcd_gfz = "Зона без оружия"  
l.hmcd_soe = "Чрезвычайное положение"  
l.hmcd_standard = "Стандартный режим"  

l.hmcd_traitor_soe = "У вас есть снаряжение, яды, взрывчатка и оружие, спрятанное в карманах. Убейте всех здесь."  
l.hmcd_traitor_gfz = "У вас есть нож, спрятанный в кармане. Убейте всех здесь."  
l.hmcd_traitor_standard = "У вас есть снаряжение, яды, взрывчатка и оружие, спрятанное в карманах. Убейте всех здесь."
l.hmcd_traitor_ww = "Этот город не настолько большой для всех нас"  

l.hmcd_gunman_soe = "Вы невиновны, но у вас есть охотничье оружие. Найдите и нейтрализуйте предателя, пока не стало слишком поздно."  
l.hmcd_gunman_gfz = "Вы свидетель убийства, хотя вас это не коснулось, лучше быть осторожным."  
l.hmcd_gunman_standard = "Вы свидетель с табельным оружием. Вы решили помочь полиции быстрее найти преступника."  
l.hmcd_gunman_ww = "Вы - шериф этого города. Вы должны найти и убить беззаконного ублюдка."

l.hmcd_bystander_soe = "Вы невиновны, полагайтесь только на себя, но держитесь в толпе, чтобы усложнить задачу предателю."  
l.hmcd_bystander_gfz = "Вы свидетель убийства, хотя вас это не коснулось, лучше быть осторожным."  
l.hmcd_bystander_standard = "Вы свидетель убийства, хотя вас это не коснулось, лучше быть осторожным."
l.hmcd_bystander_ww = "Мы должны восстановить справедливость, ведь здесь беззаконный урод убивает людей"

l.hl2dm_cmb_name = "UNIT %s"
l.hl2dm_cmb = "Комбайны"
l.hl2dm_cmb_desc = "Уничтожьте любое сопротивление."

l.hl2dm_rebel = "Повстанцы"
l.hl2dm_rebel_desc = "Уничтожьте всех комбайнов!"

l.gw_blue = "Участники банды Groove"
l.gw_red = "Участники банды Bloodz"
l.gw_blue_desc = "Убей всех уёбков из bloodz"
l.gw_red_desc = "Убей всех уёбков из groove"

l.event_maker = "Ивент-мейкер"
l.event_player = "Участник"

// Скорборд

l.sc_players = "Игроки"
l.sc_invento = "Инвентарь"
l.sc_teams = "Команды"

l.sc_copysteam = "Скопировать STEAMID"
l.sc_openprofile = "Открыть профиль"

l.sc_unable_prof = "Невозможно открыть профиль."
l.sc_unable_steamid = "Невозможно скопировать STEAMID."
l.sc_success_copy = "Успешно скопирован STEAMID (%s)"

l.sc_curround = "Текущий Раунд: %s"
l.sc_nextround = "Следующий Раунд: %s"
l.sc_team = "Команда"
l.sc_ug = "Юзергруп"
l.sc_status = "Статус"
l.sc_tps = "Тикрейт Сервера: %s"
l.sc_mutedead = "Замутить мёртвых"
l.sc_muteall = "Замутить всех"

//Радиалка
l.hg_posture = "Сменить Позу"
l.hg_resetposture = "Сбросить Позу"
l.hg_suicide = "Совершить суицид."
l.hg_unload = "Разрядить"
l.hg_drop = "Выкинуть"
l.hg_gesture = "Случаный жест"
l.hg_playphrase = "Случайная фраза"
l.hg_attachments = "Меню модификаций"

// Остальное
l.inv_drop = "Выкинуть"
l.inv_roll = "Прокрутить барабан"
l.pulse_normal = "Нормальный пульс | Отличное состояние"
l.pulse_high = "Высокий пульс | Среднее состояние"
l.pulse_low = "Пульс еле ощущаемый | Плохое состояние"
l.pulse_lowest = "Не получается нащупать пульс | Возможно мертв"
l.pulse_no = "Нет пульса | Мертв"
l.open_alpha = "ОТКРЫТАЯ АЛЬФА"
l.report_bugs = "ПОЖАЛУЙСТА, СООБЩАЙТЕ БАГИ В НАШ ДИСКОРД СЕРВЕР."
l.youre_hungry = "Ты голоден."
l.need_2_players = "Нужно минимум 2 игрока."

l.use_door = "Дверь"
l.ent_small_crate = "Малый ящик"
l.ent_medium_crate = "Средний ящик"
l.ent_large_crate = "Большой ящик"
l.ent_melee_crate = "Ящик с холодным оружием"
l.ent_weapon_crate = "Легендарный ящик"
l.ent_grenade_crate = "Ящик с гранатами"
l.ent_armor_crate = "Ящик с броней"
l.ent_explosives_crate = "Ящик со взрывчаткой"
l.ent_medkit_crate = "Медицинский ящик"
l.ent_food_crate = "Ящик с едой"
l.ent_pistol_crate = "Ящик с пистолетами"
l.use_ezammo = "Ящик с патронами"

l.use_time_bomb = "Бомба с таймером"
l.use_fragnade = "Ручная Граната"
l.use_firenade = "Зажигательная Граната"
l.use_sticknade = "Ручная граната с рукояткой"
l.use_dynam = "Динамит"
l.use_slam = "Слэмка"
l.use_landmine = "Маленькая мина"
l.use_boundingmine = "Мина лягушка"
l.use_smokenade = "Дымовая граната"
l.use_signalnade = "Сигнальная шашка"
l.use_gasnade = "Газовая граната"
l.use_teargasnade = "Слезоточивая граната"
l.use_detpack = "Взрывной заряд"
l.use_buket = "Букет"
l.use_tnt = "Сатчель"
l.use_button = "Кнопка"

l.alive = "Живой"
l.unalive = "Мёртв"
l.unknown = "Неизвестно"
l.spectating = "Наблюдает"
l.spectator = "Наблюдатель"

l.cant_kick = "СУКА! Моя нога."
l.leg_hurt = "Я не могу пинать."
l.uncon = "БЕЗ СОЗНАНИЯ"

l.heal = "Подлечить %s"
l.wep_delay = "Задержка: %s"
l.wep_dmg = "Урон: %s"
l.wep_force = "Сила: %s"

l.item_notexist = "Предмет не существует."

l.hasnt_pulse = "У него нет пульса."
l.otrub_but_he_live = "Он отключился но живой"
l.has_pulse = "У него есть пульс"

l.r_close = "Нажми R чтобы закрыть."

//Локализация говна
l.ied_plant = "Заложить IED"
l.ied_metalprop = "в металлический проп"

l.weapon_bandage = "Бинт"
l.weapon_medkit_hg = "Аптечка"
l.weapon_painkillers_hg = "Болеутоляющие"
l.weapon_adrenaline = "Адреналин"

l.weapon_beton = "Съедобная арматура"
l.weapon_burger = "Бургер"
l.weapon_water_bottle = "Бутылка воды"
l.weapon_canned_burger = "Консервированный бургер"
l.weapon_milk = "Молоко"
l.weapon_chips = "Чипсы"
l.weapon_energy_drink = "Monster Energy"

l.weapon_ied = "Взрывчатка"
l.ied_plant = "Заложить взрывчатку"
l.ied_metalprop = "в металлический проп"
l.weapon_hands = "Руки"

l.weapon_radio = "Рация"

l.weapon_handcuffs = "Стяжки"

l.weapon_pbat = "Полицейская Дубина"
l.weapon_sog = "SOG SEAL 2000"
l.weapon_crowbar_hg = "Монтировка"
l.weapon_fubar = "Фубар"
l.weapon_hammer = "Молоток"
l.weapon_hatchet = "Топорик"
l.weapon_axe = "Топор"
l.weapon_shovel = "Томагавк"
l.weapon_melee = "Боевой Нож"
l.weapon_tagila = "Кувалда"
l.weapon_hg = "Лопата"
l.weapon_machete = "Мачете"
l.weapon_traitor = "Байонет"
l.weapon_cs_go = "Нож"
l.weapon_hg_crowbar = "Монтировка"
l.weapon_iceaxe = "Ледоруб"
l.weapon_suitcharger = "SuitCharger"


hg.Localizations.ru = l