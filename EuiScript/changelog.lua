local E, L, V, P, G = unpack(ElvUI)
local ChangeLog = E:NewModule('ChangeLog', 'AceEvent-3.0')
local S = E:GetModule('Skins')

-- by eui.cc@20170625

-- Cache global variables
-- Lua functions
local gmatch, gsub, find, sub = string.gmatch, string.gsub, string.find, string.sub
local tinsert = table.insert
local pairs, tonumber = pairs, tonumber
-- WoW API / Variables
local CreateFrame = CreateFrame

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: MERData, PlaySound, UISpecialFrames

local ChangeLogWebData = [=[
<b>20180123A</b>
<b>1. 更新集合石插件.</b>
<b>2. 整合@玩家 提示功能.</b>
<b>3. 修正神器能量条数值显示问题.</b>
<b>4. 更新稀有检测.</b>
<b>20180122A</b>
<b>1. DBM更新至17190.</b>
<b>2. 一些系统皮肤和API调整.</b>
<b>3. 修正装备属性统计有时无法显示的问题.</b>
<b>4. 更新稀有检测.</b>
<b>20180118A</b>
<b>1. DBM更新至17181.</b>
<b>2. 更新系统皮肤和字体定义等适配7.3.5.</b>
<b>3. 更新大秘境计时插件.</b>
<b>4. 更新一键宏模块.</b>
<b>5. 更新稀有检测.</b>
<b>6. 一些内置库更新.</b>
<b>20180114AA</b>
<b>1. DBM更新至17173.</b>
<b>2. 内核更新，姓名版增加治疗预估等.</b>
<b>3. 更新GSE一键宏模块.</b>
<b>20171230A</b>
<b>1. DBM更新至17076.</b>
<b>2. 内核更新，动作条增加冷却变色选项，姓名版修正层级问题，一些系统皮肤修正等.</b>
<b>20171221A</b>
<b>1. 更新DBM至17029.</b>
<b>2. 更新Rematch插件.</b>
<b>3. 集合石更新.</b>
<b>4. 内核更新，修正一些系统皮肤，姓名版增加框体层级过滤.</b>
<b>5. OUF等库更新.</b>
<b>20171209A</b>
<b>1. 更新DBM至16955.</b>
<b>2. 修正背包物品更新的问题.</b>
<b>3. 集合石更新.</b>
<b>20171206A</b>
<b>1. 更新DBM至16930.</b>
<b>2. 圣物观察更新.</b>
<b>3. 修正自动任务物品显示以支持世界任务物品,添加新符文白名单.</b>
<b>20171205A</b>
<b>1. 更新OUF库,以彻底禁止王座中载具血条的显示.</b>
<b>2. DBM更新16921.</b>
<b>3. 姓名版更新,过滤器增加以玩家为目标,不可打断施法等过滤器等.</b>
<b>20171130B</b>
<b>1. 单体框体增加载具切换开关，用来开关当玩家进行载具时框体是否显示载具单元的行为.</b>
<b>2. 更新OUF库以解决进入载具框体不可用问题.</b>
<b>3. 更新DBM至16887.</b>
<b>20171130A</b>
<b>1. 更新DBM至16882和中文语音包.</b>
<b>2. 增加新副本RaidDebuff.</b>
<b>3. 增加复制聊天单行的功能,默认关闭.</b>
<b>20171128A</b>
<b>1. 更新EUI核心,一些系统皮肤美化修正.</b>
<b>2. 更新集合石插件.</b>
<b>3. 修正装备属性统计有时无法显示的问题.</b>
<b>4. 更新DBM至16872和中文语音包.</b>
<b>5. 更新Rematch插件.</b>
<b>6. 更新GSE一键宏模块.</b>
<b>7. Skada 增加邪能炸药模块.</b>
<b>20171108A</b>
<b>1. 更新EUI核心,一些系统皮肤美化修正.</b>
<b>2. 更新DBM至16843.</b>
<b>3. 修正熔炉模拟插件开关失效问题.</b>
<b>4. 修改迷失控制样式.</b>
<b>20171103A</b>
<b>1. 更新EUI核心.</b>
<b>2. 更新DBM至16839.</b>
<b>3. 更新美化皮肤模块.</b>
<b>4. 更新大秘境计时模块.</b>
<b>5. 更新圣物观察数据.</b>
<b>6. 更新一键宏数据.</b>
<b>20171008A</b>
<b>1. 更新一键宏插件.</b>
<b>2. 更新DBM至16773.</b>
<b>3. 更新Rematch插件.</b>
<b>4. 姓名板增加持续时间位置设置等.</b>
<b>5. 其它一些相关更新.</b>
<b>20170922A</b>
<b>1. 继续修正角色面板装等显示和装备属性统计的神器装等显示.</b>
<b>2. DBM更新至16733.</b>
<b>20170921A</b>
<b>1. 姓名版一般设置里的目标指示器增加大小和位置选项.</b>
<b>2. 修正装备属性统计中神器等级显示.</b>
<b>3. 增强功能的界面相关设置中加入熔炉模拟插件的开关.</b>
<b>4. 神器框重新加入的自由拖动功能.</b>
<b>5. 禁用RareScanner Log 窗口显示.</b>
<b>20170920B</b>
<b>1. 修正EUI设置界面的ACE库报错,需大退游戏.</b>
<b>20170920A</b>
<b>1. 移除神器框的拖动，修正一处LUA错误.</b>
<b>2. 更新ACE3库,解决与其它插件兼容性问题.</b>
<b>20170919A</b>
<b>1. 修正任务追踪框字体设置后重载失败的问题.</b>
<b>2. 更新稀有检测软件，重新启用声音.</b>
<b>3. 更新圣物观察插件.</b>
<b>4. 集成熔炉圣物比较插件.</b>
<b>5. 更新新的角色面板装等显示模块.</b>
<b>6. 修正团队合剂和符文检查（感谢k99k5网友）.</b>
<b>7. 集成更多的职业一键宏.</b>
<b>8. 增加神器相关框体的自由拖动.</b>
<b>9. 美化皮肤插件更新,增加MythicKeystoneStatus,QuikEmotes,tdBattlePetScript等插件皮肤.</b>
<b>10. 更新DBM语音版.</b>
<b>11. 更新姓名版模块,现可以在副本中显示暴雪原始友方血条等.</b>
<b>20170912A</b>
<b>1. 修正任务追踪框折叠后自动任务完成按钮不隐藏的问题.</b>
<b>2. 过滤器中增加玩家施法的和阻止玩家施法的过滤器.</b>
<b>3. 一些默认框体的字体字号设置变更.</b>
<b>4. 修正好友分组的LUA错误.</b>
<b>5. 修正任务等级显示的一些错误.</b>
<b>6. 添改一些副本DEBUFF,默认使用技能ID匹配.并可设置透明度.</b>
<b>20170907A</b>
<b>1. 修正增强功能的设置项显示错误并重新调整样式.</b>
<b>2. 所有过滤器设置中加入重置过滤器的按钮功能.</b>
<b>3. 更新DBM语音版.</b>
<b>20170905B</b>
<b>1. 修正一处LUA错误.</b>
<b>20170906A</b>
<b>1. 添加显示所有的过滤器，用来显示所有的BUFF和DEBUFF。默认添加到队伍框体的DEBUFF里.</b>
<b>2. 更新DBM语音版.</b>
<b>20170905B</b>
<b>1. 更新集合石-新增的世界任务右键没有创建集合石活动的问题,搜索活动时卡顿的问题.</b>
<b>20170905A</b>
<b>1. 修改姓名版,单位框体光环和光环条的过滤器优先级.</b>
<b>2. 修改Masque皮肤模块加动态加载，调整动作条相关选项.</b>
<b>3. 移除一处影引世界光标放置的插件污染.</b>
<b>20170903B</b>
<b>1. 修正目标框体过滤器预置错误.</b>
<b>2. 修正圣物观察错误.</b>
<b>20170903A</b>
<b>1. 更改一些框体BUFF，DEBUFF的过滤器优先级预置.</b>
<b>2. 圣物观察更新并默认开启，增加显示玩家本人的虚空之光熔炉特性（不能显示目标的）.</b>
<b>3. 大秘境计时更新.</b>
<b>4. 地图宝藏模块更新.</b>
<b>5. 世界飞行地图更新.</b>
<b>6. 更新DBM至16688.</b>
<b>7. 修正鼠标 提示血条设置为顶端时RL会被重置的问题.</b>
<b>20170901B</b>
<b>1. 修正有些插件设置界面的BUG.</b>
<b>2. 自动更新会删除魔兽达人插件,据说对集合石有影响.</b>
<b>20170901A</b>
<b>1. 调整部份框体默认过滤器设置.</b>
<b>2. 自动更新会删除魔兽达人插件,据说对集合石有影响.</b>
<b>3. 修正单位框体一些目标切换选择事件的问题.</b>
<b>4. 更新飞行地图,对新地图进行了处理.</b>
<b>5. 修正迷失控制样式,一些内置库更新.</b>
<b>20170831E</b>
<b>1. 完成姓名版和单位框体新过滤器设置页的汉化.</b>
<b>2. 修正GSE和队长分配的LUA错误.</b>
<b>20170831D</b>
<b>1. 更新集合石插件.</b>
<b>2. 修正离线数据中心密语记录错误.</b>
<b>3. 修正解锁界面设置项丢失.</b>
<b>4. 恢复一般设置材质字体中的数值颜色为蓝色.</b>
<b>20170831C</b>
<b>1. 修正EUI字体错误.</b>
<b>2. 默认开启姓名版血量显示,调整默认光环尺寸.</b>
<b>3. 修正右键菜单失效的问题.</b>
<b>4. 临时禁用点击施法的注册事件,待修正.</b>
<b>20170831B</b>
<b>1. 修正飞行点错误.</b>
<b>2. 更新ACE3库.</b>
<b>3. 姓名版等过滤器调整中.</b>
<b>20170831A</b>
<b>1. 7.3适配修正.</b>
<b>2. EUI姓名版，单位框体使用新的过滤系统.</b>
<b>20170810B</b>
<b>1. 修正圣物观察开关失效的问题.</b>
<b>20170810A</b>
<b>1. 更新DBM至16569.</b>
<b>2. 鼠标提示增加钥石助手模块用来显示前缀.</b>
<b>3. Masque增加CleanUI系列美化皮肤.</b>
<b>4. 鼠标提示的圣物观察默认禁用，开关需要重载生效.</b>
<b>20170730B</b>
<b>1. 紧急修复0730A的LUA错误.</b>
<b>20170730A</b>
<b>1. MSBT改写内置的千位缩写为EUI的数字缩写，开关在单体插件中.</b>
<b>2. GSE一键宏插件更新，修正一处报错.</b>
<b>3. 更新DBM至16526.</b>
<b>20170726C</b>
<b>1. 自定义延迟容限设置默认禁用,默认值调为400.</b>
<b>20170726B</b>
<b>1. 修复UI缩放不能调至小于0.5的问题.</b>
<b>2. 更新GSE一键宏插件, 并屏蔽其版本检测.</b>
<b>3. 更新美化皮肤模块.</b>
<b>4. 更新DBM至16500.</b>
<b>5. 修正Maqsue Goldpaw 皮肤路径错误.</b>
<b>6. 动作条设置增加被暴雪移除的自定义延迟容限,默认30ms,可以设置与真实世界延时相匹配的值.</b>
<b>20170723A</b>
<b>1. 更改LUA错误记录清空方式？不知是否由此引起的卡蓝条？.</b>
<b>20170722A</b>
<b>1. 修正更新记录呼出时的报错.</b>
<b>2. 修正LUA错误记录未被正确的设置上限的问题,WTF中缓存记录被限制到20个.</b>
<b>3. 大秘境计时更新进度表.</b>
<b>4. 更新DBM至16488.</b>
<b>20170719A</b>
<b>1. 修正设置视野距离时的报错.</b>
<b>2. 修正禁用Rematch后,其美化皮肤出错的问题.</b>
<b>20170718A</b>
<b>1. 更新DBM至16458.</b>
<b>2. 玩家框体的能量条增加按百分比显示自定义颜色功能.</b>
<b>3. 更新集合石, 关闭快速加入功能.</b>
<b>4. 更新Skada伤害统计插件,更新其误伤模块.</b>
<b>5. 更新Rematch宠物战队插件和美化皮肤.</b>
<b>20170708A</b>
<b>1. 默认打开紧凑姓名版开关，使姓名版不会超出屏幕.</b>
<b>2. 修正团队/小队信息报告装等格式化问题.</b>
<b>20170707B</b>
<b>1. 团队/小队信息面板增加队伍号显示, 并支持按队伍号排序.</b>
<b>2. 团队/小队信息面板现可以发送全部成员信息到当前团队频道, 增加成员数量和团队平均装等显示.</b>
<b>20170707A</b>
<b>1. 修正姓名版光环额外黑名单过滤器不能正常工作的问题.</b>
<b>2. 增加团队/小队信息面板,显示成员装等、专精,可由频道切换条的图标开关显示.</b>
<b>3. DBM更新至16423.</b>
<b>20170706A</b>
<b>1. DBM更新至16418.</b>
<b>2. 默认关闭姓名版字体描边,防止Add时引起帧数下降.</b>
<b>3. 调整姓名版BOSS框体贴边行为和堆叠时的间距使其更紧凑.</b>
<b>20170704A</b>
<b>1. DBM更新至16400.</b>
<b>2. 修正背包和鼠标提示装等显示.</b>
<b>3. 要塞增强包更新.</b>
<b>4. 内置库更新.</b>
<b>20170630A</b>
<b>1. 修正距离检查函数.</b>
<b>2. 修正更新记录框体一处报错.</b>
<b>3. 修正EUI设置界面一键宏设置项错误.</b>
<b>4. 修正经验条多个背景的问题.</b>
<b>5. DBM更新至16375.</b>
<b>20170629B</b>
<b>1. DBM更新至16359.</b>
<b>2. 更新ROLL物品列表数据.</b>
<b>3. 精简增强功能中自动清理内存和部份代码,以测试是否可能由此引起的游戏卡死问题.</b>
<b>20170626A</b>
<b>1. DBM更新至16340.</b>
<b>2. 修正更新记录模块,使其可以显示所有的更新历史,并用不同的颜色来区分新的记录.</b>
<b>3. 鼠标提示等模块修改对隐藏目标的操作防止插件污染.</b>
<b>4. 修复单位框体目标边框染色设置失效的问题.</b>
<b>5. 简中客户端设置界面加入更新历史按钮.</b>
<b>20170625A</b>
<b>1. 解决LUA错误收集重复的问题.</b>
<b>2. 修正自定义表情不显示.</b>
<b>3. 大秘境计时修正死亡次数和系统自带重合的问题.</b>
<b>4. 更新萨格拉斯之墓副本DEBUFF.</b>
<b>5. Skada更新,增加团队HPS和个人HPS统计.</b>
<b>6. 添加萨格拉斯之墓副本中绝望的聚合体玩家被拉入灵魂世界后，技能施法距离的修正.</b>
<b>7. 修正鼠标提示玩家服务器名隐藏的问题,修正天赋和装等提示文字不为中文的问题.</b>
<b>8. DBM更新至16334,增加装备耐久检查命令/dbm durability</b>
<b>20170624A</b>
<b>1. 修复团框姓名不显示的问题，修复自定义表情不显示，修复透明主题下聊天输入框背景问题.</b>
<b>2. 更新大秘境增强插件，以修复重复的死亡次数追踪问题.</b>
<b>3. DBM更新至16312.</b>
<b>4. 添加更多的副本DEBUFF.</b>
<b>20170623A</b>
<b>1. EUI内核更新,精简一部份代码.</b>
<b>2. DBM更新至16306,并更新夏一可语音包.</b>
<b>3. 要塞增强包更新.</b>
<b>20170622A</b>
<b>1. 修正团框的就位图标设置无效的问题.</b>
<b>2. 从DBM-VPXF补充一部原夏一可语音包中少的语音,听到男声勿奇怪.</b>
<b>3. 可ROLL装备数据更新.</b>
<b>4. DBM更新至16289.</b>
<b>5. RaidDebuff补充新的数据.</b>
<b>20170620B</b>
<b>1. 更新EUI各模块的加载方式.</b>
<b>2. 更新Rematch宠物战队模块.</b>
<b>3. 更新一键宏插件.</b>
<b>4. 修复手工折叠任务追踪框，自动任务按钮不能隐藏的问题。增加永久关闭自动任务按钮的开关.</b>
<b>20170618A</b>
<b>1. 更新OUF库，以支持灵魂碎片裂片等新特性,未经全职业测试，有问题反馈.</b>
<b>2. 修改内置的/in延时宏,不再支持施放技能使用物品,会引起插件污染提示禁用.</b>
<b>3. 集成修改版BugSack错误收集插件,方便收集插件错误并反馈(会在小地图收集按钮中显示).</b>
<b>20170616A</b>
<b>1. 更新集合石,萨格拉斯之墓,场景战役,竞技场练习赛的活动无法显示在集合石中为暴雪导致.</b>
<b>2. 更新稀有检测插件，更新物品掉落表.</b>
<b>20170615B</b>
<b>1. 临时修正人集合石不能查找队伍的问题.</b>
<b>20170615A</b>
<b>1. 信息文字的本地化，一些系统皮肤修正.</b>
<b>20170613A</b>
<b>1. 移除一键宏插件一些未知宏的提示信息.</b>
<b>2. DBM更新至16268.</b>
<b>3. Masque 皮肤更新.</b>
<b>4. 圣物观察模块更新添加7.2.5数据.</b>
<b>5. 姓名版的光环可以选用黑名单过滤器.</b>
<b>6. 修正任务等级增加的报错姓名版的光环可以选用黑名单过滤器.</b>
<b>7. 单体插件中集成APIInterface模块，可在游戏中查看API方法.</b>
<b>8. 内核预更新支持7.2.5.</b>
<b>20170606A</b>
<b>1. 更新Rematch插件和皮肤.</b>
<b>2. DBM更新至16264.</b>
<b>3. 更新Masque模块并增加多套皮肤.</b>
<b>4. 更新幻化物品排序增强WardrobeSort插件，并美化下拉框.</b>
<b>5. 整体替换下拉菜单库为LibUIDropDownMenu.</b>
<b>6. 增加[affix:necrotic-rot],[affix:necrotic-rot-percent]两个标签对应死疽溃烂DEBUFF的层数和百分比,增加[affix:bursting],[affix:bursting-percent]标签对应 爆裂 DEBUFF的层数和百分比.</b>
<b>20170523A</b>
<b>1. 更新Rematch插件和皮肤.</b>
<b>2. DBM更新至16243.</b>
<b>3. 增加WardrobeSort 幻化排序插件.</b>
<b>4. 更新内置库，修复一处偶发的LUA错误.</b>
<b>20170517A</b>
<b>1. RL工具箱移除烟幕弹，增加幻影打击.</b>
<b>2. 自动任务物品中增加两种爆发药水ID.</b>
<b>3. 修正双天赋配置设置界面乱码问题.</b>
<b>4. 姓名版的一般设置中增加光环的时间和层数偏移设置.</b>
<b>5. DBM更新至16230.</b>
<b>6. 改善神器能量物品的识别方法.</b>
<b>7. 更新一键宏插件，更新Skada伤害统计插件.</b>
<b>8. 新的任务成就追踪框进度条皮肤.</b>
<b>20170510A</b>
<b>1. 修正HandyNotes设置错误.</b>
<b>2. 修正[PlayerTargetSpeed]标签的LUA错误.</b>
<b>3. 更新DBM至 16220.</b>
<b>20170509A</b>
<b>1. 禁用智能任务追踪模块.</b>
<b>2. 聊天框增加物品装等显示.</b>
<b>3. 单位框体增加玩家目标速度显示标签 [<span style="color: #3366ff;">PlayerTargetSpeed</span>].</b>
<b>4. 修复自动邀请防止中途因异常退出.</b>
<b>5. 增强功能增加了进副本自动折叠任务追踪框的开关.</b>
<b>20170508A</b>
<b>1. 当抗魔联军战争物资不为0时，不显示要塞资源.</b>
<b>2. 更新递减控制图标显示，增加类型选项并更新技能表.</b>
<b>3. 一些系统皮肤更新修正.</b>
<b>4. 更新DBM至 16216.</b>
<b>5. 队伍和团框的就位图标增加设置选项.</b>
<b>20170429B</b>
<b>1. 修正单位框体错误的边框色预设.</b>
<b>20170429A</b>
<b>1. 单位框体增加单独的边框色设置.</b>
<b>2. 更新大秘境计时插件.</b>
<b>3. 更新DBM至16190.</b>
<b>20170419C</b>
<b>1. 修复自动任务物品神器能量占用任务物品位置的问题，优化其占用.</b>
<b>2. 增加功能的自动任务物品中加入神器能量的开关.</b>
<b>20170419B</b>
<b>1. 修复自动任务物品导致的卡顿.</b>
<b>20170419A</b>
<b>1. 自动任务物品第一个按钮改为显示背包内神器能量物品.</b>
<b>2. 鼠标提示增加最大可堆叠数显示.</b>
<b>3. 修正神器条能量文字显示.</b>
<b>20170416A</b>
<b>1. 修正信息文字选项在有些环境下报错.</b>
<b>2. 修正圣物观察模块一些库加载的问题.</b>
<b>3. 修正过滤器团队减伤设置界面的报错.</b>
<b>20170415C</b>
<b>1. 还原职业条背景色配色.</b>
<b>20170415B</b>
<b>1. 修正天赋配置属性模板的错误.</b>
<b>20170415A</b>
<b>1. 修正14A带来的一些LUA错误.</b>
<b>2. 更新好友面板皮肤.</b>
<b>3. 像素主题不再强制边框色，可自由设置.</b>
<b>20170414A</b>
<b>1. 更新一键宏模块,完成部份汉化,谁愿意翻译宏的帮助说明的联系我.</b>
<b>2. 移除出错的俯仰角模块.</b>
<b>3. 更新Rematch插件和皮肤.</b>
<b>4. 更新天赋配置切换模块.</b>
<b>5. 更新集合石插件.</b>
<b>6. 继续更新圣物观察模块.</b>
<b>7. 添加HandyNotes_LegionTreasures插件，用来替代 HandyNotes_LogionRaresTreasures 插件（暂未删）.</b>
<b>20170406A</b>
<b>1. 修正圣物观察模块乱码问题.</b>
<b>2. 更新邮件助手，隐藏暴雪自带的按钮.</b>
<b>3. 升级内置库，使用新的方法计算物品装等.</b>
<b>4. 更新智能任务追踪模块.</b>
<b>5. 更新稀有精英扫描模块.</b>
<b>6. MS的暗影魔计时增加神器强化等级设置选项.</b>
<b>7. 一些系统皮肤修正，神器条数值显示修正.</b>
<b>8. 更新DBM至16137.</b>
<b>20170401B</b>
<b>1. 更新圣物观察模块.</b>
<b>2. 修正因钥石影响自动出售灰色物品的问题.</b>
<b>3. 智能任务追踪模块增加开关.</b>
<b>20170401A</b>
<b>1. 更新集合石插件.</b>
<b>2. 一些系统皮肤物品边框染色修正.</b>
<b>3. 增加智能任务追踪模块,可对追踪的任务自动排序.</b>
<span style="color: #00ffff;"><b>4. 神器界面点不开的，灰色物品无法自动售卖的，请检查安装的单体插件部份.</b></span>
<b>20170330B</b>
<b>1. 更新DBM至16103.</b>
<b>2. 一些系统皮肤修正.</b>
<b>3. 添加一些薩格拉斯之墓的RaidDebuff.</b>
<b>4. 更新大秘境计时插件.</b>
<b>5. 更新一键宏插件.</b>
<b>20170330A</b>
<b>1. 适配WoW 7.2.</b>
<b>2. 更新DBM至16061.</b>
<b>3. 更新集合石插件.</b>
<b>4. 更新大地图插件，飞行地图模块.</b>
<b>5. 更新大秘境计时插件.</b>
<b>6. 更新可ROLL装备列表插件.</b>
<b>7. 更新Skada伤害统计插件等.</b>]=];	

local function ReplaceB(str,toggle)
	local tmp
	if toggle then
		tmp = str:gsub("<b>","    "):gsub("</b>","\n")
	else
		tmp = str:gsub("<b>",""):gsub("</b>","\n")
	end
	return tmp
end

local function ModifiedString(str)
	local tmp = gsub(str, "<b>%d%d%d%d%d%d%d%d%u</b>", function(s)
		local st = ReplaceB(s)
		local s1 = tonumber(st:gsub("\n",""):sub(1,8)) or 0
		local s2 = tonumber((E.global.Ver):sub(1,8)) or 0 --判断更新前的版本
		if s1 > s2 then
			return "|cffff7d0a" .. st .. "|r"
		else
			return "|cFFFFFF00" .. st .. "|r"
		end
	end)
	return ReplaceB(tmp, true)
end

local function GetChangeLogInfo(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

function ChangeLog:CreateLogFrame()
	local title = CreateFrame("Frame", "EUIChangeLogFrame", E.UIParent)
	title:SetPoint("CENTER",  E.UIParent, 'CENTER', 0, 200)
	tinsert(UISpecialFrames, "EUIChangeLogFrame")
	title:SetSize(578, 30)
	title:SetTemplate("Transparent")
	title.text = title:CreateFontString(nil, "OVERLAY")
	title.text:SetPoint("CENTER", title, 0, -1)
	title.text:SetFont(E["media"].normFont, 16)
	title.text:SetText("|cffff7d0aEUI|r - " .. L["ChangeLog"])
	title:SetMovable(true)
	title:EnableMouse(true)
	title:Hide()
	title:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and not self.isMoving then
			self:StartMoving();
			self.isMoving = true;
		elseif button == "RightButton" and not self.isSizing then
			self:StartSizing();
			self.isSizing = true;
		end
	end)
	title:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing();
			self.isMoving = false;
		elseif button == "RightButton" and self.isSizing then
			self:StopMovingOrSizing();
			self.isSizing = false;
		end
	end)
	title:SetScript("OnHide", function(self)
		if ( self.isMoving or self.isSizing) then
			self:StopMovingOrSizing();
			self.isMoving = false;
			self.isSizing = false;
		end
	end)

	local frame = CreateFrame("Frame", nil, title)
	frame:SetTemplate('Transparent')
	frame:Size(600, 200)
	frame:Point('TOPRIGHT', title, 'BOTTOMRIGHT', 0, -2)
	frame:SetResizable(true)
	frame:SetMinResize(350, 100)
	frame:SetFrameStrata("DIALOG")
	
	local icon = CreateFrame("Frame", nil, frame)
	icon:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -20, 2)
	icon:SetSize(40, 40)
	icon:SetTemplate("Transparent")
	icon.bg = icon:CreateTexture(nil, "ARTWORK")
	icon.bg:Point("TOPLEFT", 2, -2)
	icon.bg:Point("BOTTOMRIGHT", -2, 2)
	icon.bg:SetTexture([[Interface\AddOns\ElvUI\media\textures\eui_logo.tga]])

	local scrollArea = CreateFrame("ScrollFrame", "EUIChangeLogScrollFrame", frame, "UIPanelScrollFrameTemplate")
	scrollArea:Point("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)
	S:HandleScrollBar(EUIChangeLogScrollFrameScrollBar)

	scrollArea:SetScript("OnSizeChanged", function(self)
		EUIChangeLogFrameEditBox:Width(self:GetWidth())
		EUIChangeLogFrameEditBox:Height(self:GetHeight())
	end)
	scrollArea:HookScript("OnVerticalScroll", function(self, offset)
		EUIChangeLogFrameEditBox:SetHitRectInsets(0, 0, offset, (EUIChangeLogFrameEditBox:GetHeight() - offset - self:GetHeight()))
	end)

	local editBox = CreateFrame("EditBox", "EUIChangeLogFrameEditBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:Width(scrollArea:GetWidth())
	editBox:Height(200)
	editBox:SetScript("OnEscapePressed", function() EUIChangeLogFrame:Hide() end)
	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "EUIChangeLogFrameCloseButton", title, "UIPanelCloseButton")
	close:Point("TOPRIGHT")
	close:SetFrameLevel(close:GetFrameLevel() + 1)
	close:EnableMouse(true)

	S:HandleCloseButton(close)
end

function E:ToggleChangeLog()
	local frame = EUIChangeLogFrame or ChangeLog:CreateLogFrame()

	EUIChangeLogFrameEditBox:SetText(ModifiedString(ChangeLogWebData));
	PlaySound(88)

	if not E.global.Ver then ChangeLog:CheckVersion() end
	
	if not EUIChangeLogFrame:IsShown() then
		EUIChangeLogFrame:Show()
	else
		EUIChangeLogFrame:Hide()
	end
end

function ChangeLog:CheckVersion()
	if GetLocale() == 'zhCN' then
		if not E.global.Ver or (E.global.Ver and E.global.Ver ~= E.Ver) then
			E:ToggleChangeLog()
			E.global.Ver = E.Ver
			E:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
end

function ChangeLog:Initialize()
	if E.private.install_complete == nil then return; end

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "CheckVersion")
	
end

local function InitializeCallback()
	ChangeLog:Initialize()
end

E:RegisterModule(ChangeLog:GetName(), InitializeCallback)