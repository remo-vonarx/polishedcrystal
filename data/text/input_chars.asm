; see engine/naming_screen.asm

NameInputLower:
	table_width 1
	rawchar "abcdefghi"
	rawchar "jklmnopqr"
	rawchar "stuvwxyz-"
	rawchar "äöüé'()/0"
	rawchar "123456789"
	assert_table_length 9 * 5

NameInputUpper:
	table_width 1
	rawchar "ABCDEFGHI"
	rawchar "JKLMNOPQR"
	rawchar "STUVWXYZ "
	rawchar "ÄÖÜ¥<PK><MN>★♥♪"
	rawchar "?!♂♀.,:&%"
	assert_table_length 9 * 5

MailEntry_Uppercase:
	table_width 1
	rawchar "ABCDEFGHIJ"
	rawchar "KLMNOPQRST"
	rawchar "UVWXYZ?!…:"
	rawchar "1234567890"
	rawchar "ÄÖÜ<PK><MN><PO><KE>&♂♀"
	assert_table_length 10 * 5

MailEntry_Lowercase:
	table_width 1
	rawchar "abcdefghij"
	rawchar "klmnopqrst"
	rawchar "uvwxyz -.,"
	rawchar "äöüé's¥×/()"
	rawchar "“”'%↑↓№★♥♪"
	assert_table_length 10 * 5

NameInputLowerQwerty:
	table_width 1
	rawchar "qwertyuio"
	rawchar "asdfghjkl"
	rawchar "zxcvbnmp-"
	rawchar "äöüé'()/0"
	rawchar "123456789"
	assert_table_length 9 * 5

NameInputUpperQwerty:
	table_width 1
	rawchar "QWERTYUIO"
	rawchar "ASDFGHJKL"
	rawchar "ZXCVBNMP "
	rawchar "ÄÖÜ¥<PK><MN>★♥♪"
	rawchar "?!♂♀.,:&%"
	assert_table_length 9 * 5

MailEntryQwerty_Uppercase:
	table_width 1
	rawchar "QWERTYUIOP"
	rawchar "ASDFGHJKL:"
	rawchar "ZXCVBNM?!…"
	rawchar "1234567890"
	rawchar "ÄÖÜ<PK><MN><PO><KE>&♂♀"
	assert_table_length 10 * 5

MailEntryQwerty_Lowercase:
	table_width 1
	rawchar "qwertyuiop"
	rawchar "asdfghjkl-"
	rawchar "zxcvbnm,. "
	rawchar "äöüé's¥×/()"
	rawchar "“”'%↑↓№★♥♪"
	assert_table_length 10 * 5
