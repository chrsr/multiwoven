import { getConnectorsDefintions, ConnectorsDefinationApiResponse } from '@/services/connectors';
import { getDestinationCategories } from '@/views/Connectors/helpers';
import { useContext, useState } from 'react';
import { Box, Grid, Image, Text, Wrap } from '@chakra-ui/react';
import ContentContainer from '@/components/ContentContainer';
import { ALL_DESTINATIONS_CATEGORY } from '@/views/Connectors/constant';
import { Connector } from '@/views/Connectors/types';
import { SteppedFormContext } from '@/components/SteppedForm/SteppedForm';
import useQueryWrapper from '@/hooks/useQueryWrapper';

const SelectDestinations = (): JSX.Element => {
  const { stepInfo, handleMoveForward } = useContext(SteppedFormContext);
  const [selectedCategory, setSelectedCategory] = useState<string>(ALL_DESTINATIONS_CATEGORY);

  const { data } = useQueryWrapper<ConnectorsDefinationApiResponse, Error>(
    ['datasources', 'destination'],
    () => getConnectorsDefintions('destination'),
    {
      refetchOnWindowFocus: false,
      refetchOnMount: false,
      gcTime: Infinity,
    },
  );

  const connectors = data?.data ?? [];
  const destinationCategories = getDestinationCategories(connectors);

  const onDestinationSelect = (destination: Connector) => {
    handleMoveForward(stepInfo?.formKey as string, destination.name);
  };

  return (
    <Box display='flex' alignItems='center' justifyContent='center' width='100%'>
      <ContentContainer>
        <Box marginBottom='20px'>
          <Wrap spacing='24px'>
            {destinationCategories.map((category) => {
              const isSelected = category === selectedCategory;
              return (
                <Box
                  key={category}
                  padding='6px 12px'
                  borderRadius='100px'
                  backgroundColor={isSelected ? 'brand.400' : 'none'}
                  color={isSelected ? 'gray.100' : 'black.200'}
                  borderWidth='1px'
                  borderStyle='solid'
                  borderColor={isSelected ? 'primary.400' : 'gray.400'}
                  cursor='pointer'
                  _hover={{
                    backgroundColor: isSelected ? 'brand.400' : 'gray.100',
                  }}
                  onClick={() => setSelectedCategory(category)}
                >
                  <Text size='xs' fontWeight='semibold'>
                    {category}
                  </Text>
                </Box>
              );
            })}
          </Wrap>
        </Box>
        <Box display='flex'>
          <Grid
            templateColumns='repeat(auto-fit, minmax(min(300px, 100%), 1fr))'
            gap={4}
            width='100%'
          >
            {connectors.map((connector) =>
              selectedCategory === ALL_DESTINATIONS_CATEGORY ||
              selectedCategory === connector.category ? (
                <Box
                  key={connector.name}
                  display='flex'
                  alignItems='center'
                  borderWidth='thin'
                  padding='20px'
                  borderRadius='8px'
                  cursor='pointer'
                  borderColor='gray.400'
                  _hover={{
                    backgroundColor: 'gray.200',
                  }}
                  height='56px'
                  onClick={() => onDestinationSelect(connector)}
                >
                  <Box
                    height='40px'
                    width='40px'
                    marginRight='10px'
                    borderWidth='thin'
                    padding='5px'
                    borderRadius='8px'
                    display='flex'
                    justifyContent='center'
                    alignItems='center'
                    backgroundColor='gray.100'
                  >
                    <Image
                      src={connector.icon}
                      alt='source icon'
                      maxHeight='100%'
                      height='24px'
                      width='24px'
                    />
                  </Box>
                  <Text fontWeight='semibold' size='sm'>
                    {connector.title}
                  </Text>
                </Box>
              ) : null,
            )}
          </Grid>
        </Box>
      </ContentContainer>
    </Box>
  );
};

export default SelectDestinations;
