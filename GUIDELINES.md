# Spelling/capitalization
- use American spelling everywhere
- captialization of physical quantities (objects/functions to create those)
  follows the "natural" capitalization ignoring all Python conventions.
- Capitalization of other code follows PEP8 recommendations (snake_case for
  methods/functions/properties, CamelCase for classes)
- Prefer longer names to avoid ambiguity, e.g. prefer `energy_density` over `w`

# Repository structure
- Use `src` layout
- Separate `tests` are not deployed with the packages

# Versioning
- All packages use semver
- The metapackage's version is updated according to the largest version change
  of any of its dependent subpackages (or changes in `mammos` itself)

# Type hinting
- All code should have complete type hints.
- All typehints must use the full mammos (sub-)package's names instead of
  abbreviations. Abbreviations are only acceptable for widely known, common
  packages, e.g. `np` for `numpy`, `pd` for `pandas`, `mpl` for `matplotlib.pyplot`.
  If in doubt, use the full package name. `from` imports for type hinting are
  not allowed.
- Use `from __future__ import annotations` where required and avoid imports for
  typehinting only (use `if TYPE_CHECKING` guard)

# Style
- Follow ruff for all style decisions
- Exception: increased line length 120 characters for all notebooks

# Return types
- Return custom composite objects (based on dataclass) whenever a
  function/method returns more than one element.
- Attributes of that object should be `mammos_entity.Entity` objects whenever
  possible (if not possible `astropy.units.Quantity`, if not possible Python raw
  types [numbers, ...])

# Arguments to functions
Where possible/relevant accept and check the following:
- `mammos_entity.Entity`: check that we get the required entity
- `astropy.units.Quantity`: check that the units are compatible, assume the
  entity is correct
- numbers (or other basic data types): assume it is given in units of the entity base unit
