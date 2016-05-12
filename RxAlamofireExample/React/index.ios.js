'use strict';

import React, {
  Text,
  View,
} from 'react-native';

var styles = React.StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'red'
  }
});

class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>This is a simple application.</Text>
      </View>
    )
  }
}

React.AppRegistry.registerComponent('App', () => App);
