require 'excel'
include Spreadsheet

def unpack_record(data)
  data.unpack('C*').map! {|c| sprintf("%02X", c) }.join(' ')
end

  tests = [
    [
        'x =  2000',
        [2, 2000],
    ],

    [
        'x == 2000',
        [2, 2000],
    ],

    [
        'x =~ 2000',
        [2, 2000],
    ],

    [
        'x eq 2000',
        [2, 2000],
    ],

    [
        'x <> 2000',
        [5, 2000],
    ],

    [
        'x != 2000',
        [5, 2000],
    ],

    [
        'x ne 2000',
        [5, 2000],
    ],

    [
        'x !~ 2000',
        [5, 2000],
    ],

    [
        'x >  2000',
        [4, 2000],
    ],

    [
        'x <  2000',
        [1, 2000],
    ],

    [
        'x >= 2000',
        [6, 2000],
    ],

    [
        'x <= 2000',
        [3, 2000],
    ],

    [
        'x >  2000 and x <  5000',
        [4,  2000, 0, 1, 5000],
    ],

    [
        'x >  2000 &&  x <  5000',
        [4,  2000, 0, 1, 5000],
    ],

    [
        'x >  2000 or  x <  5000',
        [4,  2000, 1, 1, 5000],
    ],

    [
        'x >  2000 ||  x <  5000',
        [4,  2000, 1, 1, 5000],
    ],

    [
        'x =  Blanks',
        [2, 'blanks'],
    ],

    [
        'x =  NonBlanks',
        [2, 'nonblanks'],
    ],

    [
        'x <> Blanks',
        [2, 'nonblanks'],
    ],

    [
        'x <> NonBlanks',
        [2, 'blanks'],
    ],

    [
        'Top 10 Items',
        [30, 10],
    ],

    [
        'Top 20 %',
        [31, 20],
    ],

    [
        'Bottom 5 Items',
        [32, 5],
    ],

    [
        'Bottom 101 %',
        [33, 101],
    ],

      ]
  
bp=1
    workbook  = Workbook.new('test.xls')
    worksheet = workbook.add_worksheet
    tests.each do |test|
      expression = test[0]
      expected   = test[1]
      tokens     = worksheet.extract_filter_tokens(expression)
      result     = worksheet.parse_filter_expression(expression, tokens)
  
      testname   = expression || 'none'
      p result
      p expected
    end

