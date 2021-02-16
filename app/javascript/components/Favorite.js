import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { HeartFill } from 'react-bootstrap-icons';
import axios from 'axios';

axios.defaults.headers['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

const Favorite = ({ memoId, favoriteId, baseCount }) => {
  const [id, setId] = useState(favoriteId);
  const [count, setCount] = useState(baseCount);
  
  const clicked = async () => {
    if (id == null) {
      const { data: { id = null } } = await axios.post('/favorites', { memo_id: memoId });
      id && setId(id);
      setCount(prevCount => prevCount + 1);
    } else {
      await axios.delete(`/favorites/${id}`);
      setId(null);
      setCount(prevCount => prevCount - 1);
    }
  };
  // count = 1;
  return (
    <div  className="center">
      <React.Fragment>
        <HeartFill color={id ? 'red' : 'gray'} size={20} onClick={clicked}/>
      </React.Fragment>
      <span> {count}</span>
    </div>
  );
};

Favorite.propTypes = {};

export default props => <Favorite {...props} />;