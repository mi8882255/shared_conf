# Вливает правила shared_conf в karabiner.json (в выбранный профиль, иначе в первый).
# Использование: jq --slurpfile r layouts.json -f merge.jq karabiner.json
# - удаляет прежние правила shared_conf (повторный запуск ничего не дублирует);
# - удаляет simple modifications для fn / правого ⌘ / правого ⌥: они срабатывают раньше
#   complex-правил и перехватили бы клавиши (например, старая схема F14/F15/F16 для Raycast);
# - остальные настройки (Caps Lock и т.д.) не трогает.

def ours:   (.description // "") | startswith("shared_conf:");
def ourkey: (.from.key_code // .from.apple_vendor_top_case_key_code // "") as $k
            | ["fn", "keyboard_fn", "right_command", "right_option"] | index($k) != null;

((.profiles | map(.selected == true) | index(true)) // 0) as $i
| .profiles[$i] |= (
    .simple_modifications = ((.simple_modifications // []) | map(select(ourkey | not)))
  | .complex_modifications.rules =
      (((.complex_modifications.rules // []) | map(select(ours | not))) + $r[0].rules)
  )
