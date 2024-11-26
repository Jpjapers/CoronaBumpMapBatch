(
    -- Function to process a material
    fn processMaterial mat =
    (
        -- Check if the material is CoronaMtl or CoronaLegacyMtl
        if (classof mat == CoronaMtl or classof mat == CoronaLegacyMtl) then
        (
            if isProperty mat #mapamountBump then -- Verify the property exists
            (
                if mat.mapamountBump == 99 then -- Check the bump amount
                (
                    mat.mapamountBump = 1 -- Update the bump amount
                    format "Updated mapamountBump for material: %\n" mat.name
                )
            )
            else
            (
                format "No mapamountBump property found for material: %\n" mat.name
            )
        )
    )

    -- Function to recursively check submaterials
    fn checkSubMaterials mat =
    (
        if isProperty mat #materialList then -- For multi-materials
        (
            for i = 1 to mat.numsubs do
            (
                if mat[i] != undefined do processMaterial mat[i]
            )
        )
        else if isProperty mat #materials then -- For material libraries
        (
            for subMat in mat.materials do
            (
                if subMat != undefined do processMaterial subMat
            )
        )
    )

    -- Iterate through all scene materials
    for obj in objects do
    (
        if obj.material != undefined then
        (
            processMaterial obj.material
            checkSubMaterials obj.material
        )
    )

    format "Script completed.\n"
)
