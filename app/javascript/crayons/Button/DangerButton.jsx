import { h } from 'preact';
import PropTypes from 'prop-types';
import { defaultChildrenPropTypes } from '../../src/components/common-prop-types';
import { Button } from './Button';

export const DangerButton = ({
  children,
  as = 'button',
  className,
  url,
  buttonType,
  disabled,
}) => (
  <Button
    variant="danger"
    as={as}
    className={className}
    url={url}
    buttonType={buttonType}
    disabled={disabled}
  >
    {children}
  </Button>
);

DangerButton.defaultProps = {
  className: undefined,
  url: undefined,
  buttonType: 'button',
  disabled: false,
};

DangerButton.displayName = 'DangerButton';

DangerButton.propTypes = {
  children: defaultChildrenPropTypes.isRequired,
  as: PropTypes.oneOf(['a', 'button']).isRequired,
  className: PropTypes.string,
  url: PropTypes.string,
  buttonType: PropTypes.string,
  disabled: PropTypes.bool,
};