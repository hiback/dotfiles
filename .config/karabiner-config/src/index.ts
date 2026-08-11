import { ifVar, map, rule, toSetVar, writeToProfile } from 'karabiner.ts'
import { hrm } from 'karabiner.ts-greg-mods'

const spaceFn = rule(
  'SpaceFN nav layer: hold space for layer, tap for space',
).manipulators([
  map('␣', [], 'any')
    .to(toSetVar('nav_layer', 1, 0))
    .toIfAlone('␣')
    .parameters({
      'basic.to_if_alone_timeout_milliseconds': 220,
    }),

  map('h', [], 'any').to('←').condition(ifVar('nav_layer', 1)),
  map('j', [], 'any').to('↓').condition(ifVar('nav_layer', 1)),
  map('k', [], 'any').to('↑').condition(ifVar('nav_layer', 1)),
  map('l', [], 'any').to('→').condition(ifVar('nav_layer', 1)),
  map('m', [], 'any').to('f13').condition(ifVar('nav_layer', 1)),
  map(',', [], 'any').to('f14').condition(ifVar('nav_layer', 1)),
  map('.', [], 'any').to('f15').condition(ifVar('nav_layer', 1)),
])

const homeRowMods = rule('ASDF JKL; home row mods').manipulators(
  hrm(
    new Map([
      ['a', 'l⌘'],
      ['s', 'l⌥'],
      ['d', 'l⇧'],
      ['f', 'l⌃'],
      ['j', 'r⌃'],
      ['k', 'r⇧'],
      ['l', 'r⌥'],
      [';', 'r⌘'],
    ]),
  )
    .lazy(true)
    .holdTapStrategy('permissive-hold')
    .chordalHold(true)
    .simultaneousThreshold(90)
    .tappingTerm(120)
    .build(),
)

writeToProfile('Default profile', [spaceFn, homeRowMods])
