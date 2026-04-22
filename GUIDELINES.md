# Spelling/capitalization
- use American spelling everywhere
- capitalization of physical quantities (objects/functions to create those)
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
- Return custom composite objects (based on mammos_entity.EntityCollection) whenever a
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

# Examples

## Validating inputs to a function
```python
from __future__ import annotations

from typing import TYPE_CHECKING

import mammos_entity as me

if TYPE_CHECKING:
    # import with full name for type annotations (in order to make type
    # annotations as clear as possible)
    import mammos_entity
    import mammos_units
    import numpy.typing


def compute_speed(
    length: mammos_entity.Entity | mammos_units.Quantity | numpy.typing.ArrayLike,
    time: mammos_entity.Entity | mammos_units.Quantity | numpy.typing.ArrayLike,
) -> mammos_entity.Entity:
    """One-line summary.

    Long description ...

    Args:
        length: The travelled distance as :entity:`Length`.
            If no unit is provided, values are interpreted as 'm'.
        time: The travel time as :entity:`Time`.
            If no unit is provided, values are interpreted as 's'.

    Returns:
        The travelling speed as :entity:`Speed`.

    Examples:
        Passing entities:

        >>> import mammos_entity as me
        >>> length = me.Entity("Length", 10, "mm")
        >>> time = me.Entity("Time", 2, "s")
        >>> compute_speed(length, time)
        Entity(ontology_label='Speed', value=0.005, unit='m / s')

        Passing an array of raw numbers:

        >>> compute_speed([10, 20], [2, 2])
        Entity(ontology_label='Speed', value=array([5., 10.,]), unit='m / s')
    """
    # validate/convert inputs to entities
    # explicitly specify units
    length = me._entity.from_compatible("Length", "m", length=length)
    time = me.Entity.from_compatible("Time", "s", time=time)

    # operate on quantities
    speed = length.q / time.q

    # return an entity
    return me.Entity("Speed", speed)
```

## [PRELIMINARY] Subclassing EntityCollection
```python
# optionally: decorate class so that entities can no longer be modified
# once the class has been initialized
@me._entity_collection.frozen_collection
class IntrinsicProperties(me.EntityCollection):
    """Intrinsic properties of a ferromagnet.

    Detailed description ...
    """

    # define required entities by specifying them as arguments in __init__._
    def __init__(
        self,
        Ms: mammos_entity.Entity,
        A: mammos_entity.Entity,
        Tc: mammos_entity.Entity,
        extra_object: str,
        description: str = "",
    ) -> None:
        """Create a new instance.

        Args:
            Ms: :entity:`SpontaneousMagnetization`
            A: :entity:`ExchangeStiffnessConstant`
            Tc: :entity:`CurieTemperature`
            extra_object: A custom object specific to this class
            description: Description of the collection.
        """
        # validate passed entities
        me._entity.ensure_entity("SpontaneousMagnetization", Ms=Ms)
        me._entity.ensure_entity("ExchangeStiffnessConstant", A=A)
        me._entity.ensure_entity("CurieTemperature", Tc=Tc)
        # pass entites to base __init__ to initialise the collection
        super().__init__(description=description, Ms=Ms, A=A, Tc=Tc)

        # deal with custom non-entity-like objects
        # not used as entity: e.g. when iterating over collection,
        # in dataframe conversion, ignored when saving collection to disc
        self._extra_object = extra_object

    @property
    def extra_object(self):
        """An example of something sub-class specific."""
        return self._extra_object
```
